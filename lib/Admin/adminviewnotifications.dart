import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';

class adminviewnotifications extends StatefulWidget {
  const adminviewnotifications({Key? key}) : super(key: key);
  static const String id = 'adminviewnotifications';

  @override
  State<adminviewnotifications> createState() => adminviewnotificationsState();
}

class adminviewnotificationsState extends State<adminviewnotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Notifications',
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
        stream: FirebaseFirestore.instance.collection('admin notifications').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data?.docs ?? [];

          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications found.'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index].data() as Map<String, dynamic>?;

              final message = notification?['message'] as String? ?? '';
              final timestamp = notification?['timestamp'] as Timestamp?;
              final dateTime = timestamp?.toDate();

              return ListTile(
                title: Text(message),
                subtitle: dateTime != null
                    ? Text('Time: ${dateTime.toLocal()}')
                    : const Text('Time: Unknown'),
              );
            },
          );
        },
      ),
    );
  }
}
