import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peachy/Admin/adminbottomnav.dart';
import 'package:peachy/Admin/admincustomerrejectedscreen.dart';

class admincustomerrejectedorders extends StatefulWidget {
  const admincustomerrejectedorders({Key? key}) : super(key: key);
  static const String id = 'admincustomerrejectedorders';

  @override
  State<admincustomerrejectedorders> createState() => admincustomerrejectedordersState();
}

class admincustomerrejectedordersState extends State<admincustomerrejectedorders> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customers Rejected Orders',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Customers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No customers found.'));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final customerName = data['name'];
                  final customerPhoneNumber = data['phoneNumber']; // Get phone number

                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminCustomerRejectedScreen(
                              customerName: customerName,
                              customerPhoneNumber: customerPhoneNumber // Pass phone number
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9C4B4), // Button background color
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text(customerName, style: const TextStyle(color: Color(0xFF111217))),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}