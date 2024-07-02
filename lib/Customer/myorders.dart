import 'package:flutter/material.dart';
import 'package:peachy/Customer/customerapprovedorders.dart';
import 'package:peachy/Customer/customerbottomnav.dart';
import 'package:peachy/Customer/customercompletedorders.dart';
import 'package:peachy/Customer/customerpendingorders.dart';
import 'package:peachy/Customer/customerrejectedorders.dart';

class customermyorders extends StatefulWidget {

  const customermyorders({Key? key, }) : super(key: key);

  static const String id = 'customermyorders';

  @override
  State<customermyorders> createState() => customermyordersState();
}

class customermyordersState extends State<customermyorders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: const Text(
          'My Orders',
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
      bottomNavigationBar: Customerbottomnav(), // Pass currentUser
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
                    builder: (context) => const customerpendingorders(),
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
                    builder: (context) => const CustomerApprovedOrders(),
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
                    builder: (context) => const CustomerRejectedOrders(),
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
                    builder: (context) => const CustomerCompletedOrders (),
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
