import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peachy/Cleaners/cleanersbottomnav.dart';


class cleanernotification extends StatefulWidget {
  const cleanernotification({Key? key}) : super(key: key);
  static const String id = 'cleanernotification';

  @override
  State<cleanernotification> createState() => cleanernotificationState();
}

class cleanernotificationState extends State<cleanernotification> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: const Text(
          'Cleaners Notifications',
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
      bottomNavigationBar: const Cleanersbottomnav(),
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
