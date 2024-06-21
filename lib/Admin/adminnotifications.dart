import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';
import 'package:peachy/Admin/adminsendnotifictaion.dart';
import 'package:peachy/Admin/adminviewnotifications.dart';

class adminnotification extends StatefulWidget {
  const adminnotification({Key? key}) : super(key: key);
  static const String id = 'adminnotification';

  @override
  State<adminnotification> createState() => adminnotificationState();
}

class adminnotificationState extends State<adminnotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Administrator Notifications',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const adminsendnotifications(),
                  ),
                );
                // Add
              },
              icon: const Icon(Icons.send, color: Color(0xFFF9C4B4)),
              label: const Text('Send Notification'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF111217),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const adminviewnotifications(),
                  ),
                );
                // Add
              },
              icon: const Icon(Icons.notifications, color: Color(0xFFF9C4B4)),
              label: const Text('View Notifications'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF111217),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
