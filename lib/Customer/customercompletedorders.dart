import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peachy/Customer/customerbottomnav.dart';
import 'package:peachy/customer_auth_provider.dart';
import 'package:provider/provider.dart';

class CustomerCompletedOrders extends StatefulWidget {
  const CustomerCompletedOrders({Key? key}) : super(key: key);

  static const String id = 'customercompletedorders';

  @override
  State<CustomerCompletedOrders> createState() => CustomerCompletedOrdersState();
}

class CustomerCompletedOrdersState extends State<CustomerCompletedOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Completed Orders',
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
      bottomNavigationBar: const Customerbottomnav(), // Assuming CustomerBottomNav is correctly implemented
      body: FutureBuilder<List<String>>(
        future: Future.wait([
          context.read<CustomerAuthProvider>().getCustomerName(),
          context.read<CustomerAuthProvider>().getPhoneNumber(),
        ]),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching customer data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Customer data not found.'));
          } else {
            final customerName = snapshot.data![0];
            final phoneNumber = snapshot.data![1];

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('completed orders')
                  .where('name', isEqualTo: customerName)
                  .where('phoneNumber', isEqualTo: phoneNumber)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching orders data'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No completed orders found.'));
                } else {
                  final orders = snapshot.data!.docs;

                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        orders.length,
                            (index) {
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
                                tileColor: Colors.blue,
                              ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
