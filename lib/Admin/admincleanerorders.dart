import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';
import 'package:peachy/Admin/admincleanerscompletedorders.dart';
import 'package:peachy/Admin/admincleanerspendingorders.dart';

class admincleanersorders extends StatefulWidget {
  const admincleanersorders({Key? key}) : super(key: key);
  static const String id = 'admincleanersorders';

  @override
  State<admincleanersorders> createState() => admincleanersordersState();
}

class admincleanersordersState extends State<admincleanersorders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cleaners Orders',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const admincleanerspendingorders(),
                  ),
                );
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.hourglass_empty, color: Color(0xFF111217)),
              label: const Text(
                'Pending Orders',
                style: TextStyle(color: Color(0xFF111217)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Button color
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const admincleanercompletedorders(),
                  ),
                );
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.done_all, color: const Color(0xFF111217)),
              label: const Text(
                'Completed Orders',
                style: TextStyle(color: const Color(0xFF111217)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
