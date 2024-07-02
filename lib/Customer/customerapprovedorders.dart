import 'package:flutter/material.dart';
import 'package:peachy/customer_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerApprovedOrders extends StatefulWidget {
  const CustomerApprovedOrders({Key? key}) : super(key: key);

  @override
  State<CustomerApprovedOrders> createState() => CustomerApprovedOrdersState();
}

class CustomerApprovedOrdersState extends State<CustomerApprovedOrders> {
  @override
  Widget build(BuildContext context) {
    final customerProvider = context.watch<CustomerAuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Approved Orders',
          style: TextStyle(color: Color(0xFFF9C4B4)),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF111217), // very dark mix
                Color(0xFF1b2232), // somewhat dark mix
                Color(0xFF253863), // light mix
              ],
              stops: [0.0, 0.5, 1.0],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([
          customerProvider.getCustomerName(),
          customerProvider.getPhoneNumber(),
        ]),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching customer data'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No customer data available'));
          }

          final customerName = snapshot.data![0];
          final phoneNumber = snapshot.data![1];

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('verified orders')
                .where('name', isEqualTo: customerName)
                .where('phoneNumber', isEqualTo: phoneNumber)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching orders data'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No approved orders found.'));
              }

              final orders = snapshot.data!.docs;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final orderData = orders[index].data() as Map<String, dynamic>;

                        final category = orderData['category'] as String?;
                        final sites = orderData['sites'] as String?;
                        final otherServices = orderData['otherServices'] as String?;
                        final place = orderData['place'] as String?;
                        final location = orderData['location'] as String?;
                        final paymentMethod = orderData['paymentmethod'] as String?;
                        final date = orderData['date'] as String?;
                        final time = orderData['time'] as String?;

                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Category: ${category ?? 'N/A'}'),
                                Text('Sites: ${sites ?? 'N/A'}'),
                                if (otherServices != null && otherServices.isNotEmpty)
                                  Text('Other Services: $otherServices'),
                                Text('Place: ${place ?? 'N/A'}'),
                                Text('Location: ${location ?? 'N/A'}'),
                                Text('Payment Method: ${paymentMethod ?? 'N/A'}'),
                                Text('Date: ${date ?? 'N/A'}'),
                                Text('Time: ${time ?? 'N/A'}'),
                              ],
                            ),
                            tileColor: Colors.green,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
