import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';



class cleanerslist extends StatefulWidget {
  const cleanerslist ({Key? key}) : super(key: key);
  static const String id = 'cleanerslist ';

  @override
  State<cleanerslist> createState() => cleanerslistState();
}

class cleanerslistState extends State<cleanerslist> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cleaners List',
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
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Cleaners').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching Cleaners data'));
          } else if (snapshot.hasData) {
            final Cleaners= snapshot.data!.docs;
            return ListView.builder(
              itemCount: Cleaners.length,
              itemBuilder: (context, index) {
                final cleaner = Cleaners [index];
                final cleanerData = cleaner.data() as Map<String, dynamic>;
                final cleanerName = cleanerData['name'] ?? ''; // Name
                final cleanerEmail = cleanerData['email'] ?? ''; // Email
                final cleanerID = cleanerData['CleanerID'] ?? ''; // Email
                final cleanerNumber = cleanerData['phoneNumber'] ?? ''; // Phone Number

                return ListTile(
                  title: Text(cleanerName),
                  onTap: () {
                    // When a van driver folder is clicked, display their details
                    _showVanDriverDetails(context, cleanerName, cleanerEmail, cleanerID, cleanerNumber);
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No Cleaners available.'));
          }
        },
      ),

    );
  }
}

void _showVanDriverDetails(BuildContext context, String name,String email, String cleanerID, String number) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(name),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('CleanerID: $cleanerID'),
            Text('Email: $email'),
            Text('Number: $number'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}