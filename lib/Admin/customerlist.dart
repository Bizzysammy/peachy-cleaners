import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';



class customerlist extends StatefulWidget {
  const customerlist ({Key? key}) : super(key: key);
  static const String id = 'customerlist ';

  @override
  State<customerlist > createState() => customerlistState();
}

class customerlistState extends State<customerlist > {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customers List',
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
      bottomNavigationBar: const adminbottomnav(),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Customers').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching Customer data'));
          } else if (snapshot.hasData) {
            final Customers = snapshot.data!.docs;
            return ListView.builder(
              itemCount: Customers.length,
              itemBuilder: (context, index) {
                final customer = Customers [index];
                final customerData = customer.data() as Map<String, dynamic>;
                final customerName = customerData['name'] ?? ''; // Name
                final customerEmail = customerData['email'] ?? ''; // Email
                final customerLocation = customerData['location'] ?? ''; // Email
                final customerNumber = customerData['phoneNumber'] ?? ''; // Phone Number

                return ListTile(
                  title: Text(customerName),
                  onTap: () {
                    // When a van driver folder is clicked, display their details
                    _showVanDriverDetails(context, customerName, customerEmail, customerLocation, customerNumber);
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No Customers available.'));
          }
        },
      ),

    );
  }
}

void _showVanDriverDetails(BuildContext context, String name,String email, String location, String number) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(name),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Location: $location'),
            Text('Email: $email'),
            Text('Number: $number'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

