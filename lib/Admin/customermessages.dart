import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peachy/Admin/customermessagesscreen.dart';

class AdminCustomerMessages extends StatefulWidget {
  const AdminCustomerMessages({Key? key}) : super(key: key);
  static const String id = 'admincustomermessages';

  @override
  State<AdminCustomerMessages> createState() => AdminCustomerMessagesState();
}

class AdminCustomerMessagesState extends State<AdminCustomerMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer messages',
          style: TextStyle(color: Color(0xFFF9C4B4)),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D1F2D), // very dark mix
                Color(0xFF23313D), // somewhat dark mix
                Color(0xFF455A64), // light mix
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
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerMessageScreen(
                        customerId: doc.id,
                        customerName: data['name'],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9C4B4), // Button background color
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  data['name'],
                  style: const TextStyle(color: Color(0xFF111217)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
