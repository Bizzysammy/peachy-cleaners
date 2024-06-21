import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';


class AdminCleanerPendingOrdersScreen extends StatelessWidget {
  final String cleanerName;

  const AdminCleanerPendingOrdersScreen({Key? key, required this.cleanerName}) : super(key: key);

  Future<void> _openLocationInMaps(String location) async {
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$location');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$cleanerName\'s Pending Orders',
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
            .collection('verified orders')
            .where('assignedTo', isEqualTo: cleanerName)
            .get(),
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

                  // Safely access properties with null-aware operators
                  final name = orderData['name'] as String?;
                  final phone = orderData['phoneNumber'] as String?;
                  final category = orderData['category'] as String?;
                  final sites = orderData['sites'] as String?;
                  final place = orderData['place'] as String?;
                  final location = orderData['location'] as String?;
                  final paymentMethod = orderData['paymentmethod'] as String?;
                  final date = orderData['date'] as String?;
                  final time = orderData['time'] as String?;
                  final assignedTo = orderData['assignedTo'] as String?;

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
                          Text('Place: ${place ?? 'N/A'}'),
                          Text('Location: ${location ?? 'N/A'}'),
                          Text('Payment Method: ${paymentMethod ?? 'N/A'}'),
                          Text('Date: ${date ?? 'N/A'}'),
                          Text('Time: ${time ?? 'N/A'}'),
                          Text('Assigned To: ${assignedTo ?? 'N/A'}'),
                        ],
                      ),
                      tileColor: Colors.orange,
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
}
