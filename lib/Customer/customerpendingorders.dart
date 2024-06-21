import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peachy/Customer/customerbottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class customerpendingorders extends StatefulWidget {
  const customerpendingorders({Key? key}) : super(key: key);
  static const String id = 'customerpendingorders';

  @override
  State<customerpendingorders> createState() => customerpendingordersState();
}

class customerpendingordersState extends State<customerpendingorders> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MY Pending Orders',
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
      bottomNavigationBar: const Customerbottomnav(),
      body: StreamBuilder(
        stream: _firestore
            .collection('Customers')
            .doc(userId)
            .collection('myorders')
            .snapshots(),
        builder: (context, ordersSnapshot) {
          if (!ordersSnapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final orders = ordersSnapshot.data!.docs;

          if (orders.isEmpty) {
            return const Center(
              child: Text('No pending orders found.'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final orderData =
                    orders[index].data() as Map<String, dynamic>;

                    final category = orderData['category'] as String?;
                    final sites = orderData['sites'] as String?;
                    final place = orderData['place'] as String?;
                    final location = orderData['location'] as String?;
                    final paymentMethod =
                    orderData['paymentmethod'] as String?;
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
                            Text('Place: ${place ?? 'N/A'}'),
                            Text('Location: ${location ?? 'N/A'}'),
                            Text('Payment Method: ${paymentMethod ?? 'N/A'}'),
                            Text('Date: ${date ?? 'N/A'}'),
                            Text('Time: ${time ?? 'N/A'}'),
                          ],
                        ),
                        tileColor: Colors.orange,
                        trailing: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Cancel Order'),
                                  content:
                                  Text('Are you sure you want to cancel this order?'),
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
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _deleteOrder(DocumentReference orderReference) {
    orderReference.delete();
  }
}
