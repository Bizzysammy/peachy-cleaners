import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peachy/cleaner_auth_provider.dart';
import 'package:provider/provider.dart';

class CleanerCompletedOrders extends StatelessWidget {
  const CleanerCompletedOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cleanerAuthProvider = Provider.of<CleanerAuthProvider>(context);

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
                Color(0xFF111217),
                Color(0xFF1b2232),
                Color(0xFF253863),
              ],
              stops: [0.0, 0.5, 1.0],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder<String>(
        future: cleanerAuthProvider.getCleanerName(),
        builder: (context, cleanerNameSnapshot) {
          if (cleanerNameSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (cleanerNameSnapshot.hasError) {
            return const Center(child: Text('Error fetching cleaner data'));
          } else if (cleanerNameSnapshot.data == 'Unknown') {
            return const Center(child: Text('No cleaner found.'));
          } else {
            final cleanerName = cleanerNameSnapshot.data!;

            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('completed orders')
                  .where('completedBy', isEqualTo: cleanerName)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error fetching orders data'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No completed orders found.'));
                } else {
                  final orders = snapshot.data!.docs;

                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(orders.length, (index) {
                        final orderData =
                        orders[index].data() as Map<String, dynamic>;

                        final name = orderData['name'] as String?;
                        final phone = orderData['phoneNumber'] as String?;
                        final category = orderData['category'] as String?;
                        final sites = orderData['sites'] as String?;
                        final otherServices = orderData['otherServices'] as String?;
                        final place = orderData['place'] as String?;
                        final location = orderData['location'] as String?;
                        final paymentmethod =
                        orderData['paymentmethod'] as String?;
                        final date = orderData['date'] as String?;
                        final time = orderData['time'] as String?;
                        final completedBy =
                        orderData['completedBy'] as String?;

                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${name ?? 'N/A'}'),
                                Text('Phone: ${phone ?? 'N/A'}'),
                                Text('Category: ${category ?? 'N/A'}'),
                                Text('Sites: ${sites ?? 'N/A'}'),
                                if (otherServices != null && otherServices.isNotEmpty)
                                  Text('Other Services: $otherServices'),
                                Text('Place: ${place ?? 'N/A'}'),
                                Text('Location: ${location ?? 'N/A'}'),
                                Text(
                                    'Payment Method: ${paymentmethod ?? 'N/A'}'),
                                Text('Date: ${date ?? 'N/A'}'),
                                Text('Time: ${time ?? 'N/A'}'),
                                Text('Completed By: ${completedBy ?? 'N/A'}'),
                              ],
                            ),
                            tileColor: Colors.blue,
                          ),
                        );
                      }),
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
