import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';
import 'package:peachy/Admin/admincleanerorders.dart';
import 'package:peachy/Admin/admincustomerorders.dart';

class adminmyorders extends StatefulWidget {
  const adminmyorders({Key? key}) : super(key: key);
  static const String id = 'adminmyorders';

  @override
  State<adminmyorders> createState() => adminmyordersState();
}

class adminmyordersState extends State<adminmyorders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
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
                    builder: (context) => const admincustomerorders(),
                  ),
                );
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.people, color: Color(0xFFF9C4B4)),
              label: const Text(
                'Customer Orders',
                style: TextStyle(color: Color(0xFFF9C4B4)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF111217),
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
                    builder: (context) => const admincleanersorders(),
                  ),
                ); // Add your onPressed code here!
              },
              icon: const Icon(Icons.cleaning_services, color: Color(0xFFF9C4B4)),
              label: const Text(
                'Cleaners Orders',
                style: TextStyle(color: Color(0xFFF9C4B4)),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111217),// Button color
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
