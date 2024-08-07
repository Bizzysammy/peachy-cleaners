import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCustomerApprovedScreen extends StatelessWidget {
  final String customerName;
  final String customerPhoneNumber; // Receive phone number

  const AdminCustomerApprovedScreen({Key? key, required this.customerName, required this.customerPhoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$customerName\'s Approved Orders',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('verified orders') // Replace 'verified orders' with your actual collection name
            .where('phoneNumber', isEqualTo: customerPhoneNumber) // Use phone number to filter
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching orders data'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No approved orders found.'));
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
                  final paymentmethod = orderData['paymentmethod'] as String?;
                  final date = orderData['date'] as String?;
                  final time = orderData['time'] as String?;
                  final assignedTo = orderData['assignedTo'] as String?;

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
                          Text('Payment Method: ${paymentmethod ?? 'N/A'}'),
                          Text('Date: ${date ?? 'N/A'}'),
                          Text('Time: ${time ?? 'N/A'}'),
                          Text('Assigned To: ${assignedTo ?? 'N/A'}'),
                        ],
                      ),
                      tileColor: Colors.green,
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
}