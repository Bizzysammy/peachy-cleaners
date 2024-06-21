import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';
import 'package:peachy/Admin/admincustomerapprovedorders.dart';
import 'package:peachy/Admin/admincustomercompletedorders.dart';
import 'package:peachy/Admin/admincustomerpendingorders.dart';
import 'package:peachy/Admin/admincustomerrejectedorders.dart';


class admincustomerorders extends StatefulWidget {
  const admincustomerorders({Key? key}) : super(key: key);
  static const String id = 'admincustomerorders';

  @override
  State<admincustomerorders> createState() => admincustomerordersState();
}

class admincustomerordersState extends State<admincustomerorders> {






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Orders',
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
                    builder: (context) => const admincustomerspendingorders(),
                  ),
                ); //
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
                    builder: (context) => const admincustomerapprovedorders(),
                  ),
                );
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.check_circle, color: Color(0xFF111217)),
              label: const Text(
                'Approved Orders',
                style: TextStyle(color: Color(0xFF111217)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
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
                    builder: (context) => const admincustomerrejectedorders(),
                  ),
                );
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.cancel, color: Color(0xFF111217)),
              label: const Text(
                'Rejected Orders',
                style: TextStyle(color: Color(0xFF111217)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button color
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
                    builder: (context) => const admincustomercompletedorders(),
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
