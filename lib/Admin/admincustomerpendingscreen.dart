import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminCustomerPendingOrdersScreen extends StatelessWidget {
  final String customerId; // Receive customer ID
  final String customerName;

  const AdminCustomerPendingOrdersScreen({
    Key? key,
    required this.customerId,
    required this.customerName,
  }) : super(key: key);

  Future<void> _openLocationInMaps(String location) async {
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$location');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _doesCleanerExist(String cleanerName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Cleaners')
        .where('name', isEqualTo: cleanerName)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$customerName\'s Pending Orders',
          style: const TextStyle(color: Color(0xFFF9C4B4)),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customer orders')
            .doc(customerId) // Use customer ID here
            .collection('myorders')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching orders data'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No pending orders found.'));
          } else {
            final orders = snapshot.data!.docs;

            return SingleChildScrollView(
              child: Column(
                children: List.generate(orders.length, (index) {
                  final orderData = orders[index].data() as Map<String, dynamic>;

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

                  return GestureDetector(
                    onTap: () {
                      if (location != null) {
                        _openLocationInMaps(location);
                      }
                    },
                    child: Container(
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
                          ],
                        ),
                        tileColor: Colors.orange,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    String cleanerName = '';

                                    return AlertDialog(
                                      title: const Text('Assign Order to Cleaner'),
                                      content: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text('Enter the name of the cleaner:'),
                                          TextField(
                                            onChanged: (value) {
                                              cleanerName = value;
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final exists = await _doesCleanerExist(cleanerName);
                                            if (exists) {
                                              moveDataToTargetCollectionVerifiedWithCleaner(
                                                orders[index],
                                                cleanerName,
                                              );
                                              Navigator.of(context).pop();
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: const Text('Error'),
                                                  content: const Text('Cleaner does not exist.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                          child: const Text('Assign'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Verify'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Confirm'),
                                    content: const Text(
                                        'Are you sure you want to reject this order?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              String rejectionReason = '';

                                              return AlertDialog(
                                                title: const Text('Rejection Reason'),
                                                content: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text('Enter the reason for rejection:'),
                                                    TextField(
                                                      onChanged: (value) {
                                                        rejectionReason = value;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      moveDataToTargetCollectionRejected(
                                                        orders[index],
                                                        rejectionReason,
                                                      );
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Add'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Text('Reject'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text('Reject'),
                            ),
                          ],
                        ),
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

  void moveDataToTargetCollectionVerifiedWithCleaner(
      DocumentSnapshot orderDoc,
      String cleanerName,
      ) async {
    final orderData = orderDoc.data() as Map<String, dynamic>;

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Add the data to the target collection (e.g., "verified orders").
      transaction.set(
        FirebaseFirestore.instance.collection('verified orders').doc(),
        {
          ...orderData,
          'assignedTo': cleanerName, // Add the assignedTo field
        },
      );

      // Delete the document from the source collection ("orders").
      transaction.delete(orderDoc.reference);
    });
  }

  void moveDataToTargetCollectionRejected(
      DocumentSnapshot orderDoc,
      String rejectionReason,
      ) async {
    final orderData = orderDoc.data() as Map<String, dynamic>;

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Add the data to the target collection (e.g., "rejected orders").
      transaction.set(
        FirebaseFirestore.instance.collection('rejected orders').doc(),
        {
          ...orderData,
          'rejectionReason': rejectionReason, // Add the rejectionReason field
        },
      );

      // Delete the document from the source collection ("orders").
      transaction.delete(orderDoc.reference);
    });
  }
}
