import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCleanersCompletedScreen extends StatelessWidget {
  final String cleanerName;

  const AdminCleanersCompletedScreen({Key? key, required this.cleanerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$cleanerName\'s Completed Orders',
          style: const TextStyle(color: Color(0xFFF9C4B4)),
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
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('completed orders')
            .where('completedBy', isEqualTo: cleanerName)
            .get(),
        builder: (context, snapshot) {
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
                children: List.generate(orders.length, (index) {
                  final orderData = orders[index].data() as Map<String, dynamic>;

                  // Safely access properties with null-aware operators
                  final name = orderData['name'] as String?;
                  final phone = orderData['phoneNumber'] as String?;
                  final category = orderData['category'] as String?;
                  final sites = orderData['sites'] as String?;
                  final otherServices = orderData['otherServices'] as String?;
                  final place = orderData['place'] as String?;
                  final location = orderData['location'] as String?;
                  final paymentMethod = orderData['paymentmethod'] as String?;
                  final date = orderData['date'] as String?;
                  final time = orderData['time'] as String?;
                  final completedBy = orderData['completedBy'] as String?;

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
                          Text('Payment Method: ${paymentMethod ?? 'N/A'}'),
                          Text('Date: ${date ?? 'N/A'}'),
                          Text('Time: ${time ?? 'N/A'}'),
                          Text('Completed By: ${completedBy ?? 'N/A'}'),
                        ],
                      ),
                      tileColor: Colors.blue,
                      trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('delete Order'),
                                content:
                                Text('Are you sure you want to delete this order?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deleteOrder(orders[index].reference);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            );
          }
        },
      ),
    );
  }

  void _deleteOrder(DocumentReference orderReference) {
    orderReference.delete();
  }
}

