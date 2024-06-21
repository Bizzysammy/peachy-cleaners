import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class adminsendnotifications extends StatefulWidget {
  const adminsendnotifications({Key? key}) : super(key: key);
  static const String id = 'adminsendnotifications';

  @override
  State<adminsendnotifications> createState() => adminsendnotificationsState();
}

class adminsendnotificationsState extends State<adminsendnotifications> {
  final CollectionReference notificationsRef =
  FirebaseFirestore.instance.collection('admin notifications');
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void addNotification() {
    final random = Random();
    final int randomId = random.nextInt(100000);
    final String message = messageController.text;

    if (message.isNotEmpty) {
      notificationsRef.doc(randomId.toString()).set({
        'message': message,
        'timestamp': FieldValue.serverTimestamp(), // Storing current date and time
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification added successfully')),
        );
        messageController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add notification')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Notifications',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: 'Notification Message'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: addNotification,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF111217),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                'Add Notification',
                style: TextStyle(color: Color(0xFFF9C4B4)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
