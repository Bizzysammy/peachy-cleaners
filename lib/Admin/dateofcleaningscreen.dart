import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peachy/Admin/finalreport.dart';


class DateOfCleaningScreen extends StatefulWidget {
  final String cleanerName;
  final String dayOfCleaning;
  final String cleanerId; // Pass the cleaner ID

  const DateOfCleaningScreen({
    Key? key,
    required this.cleanerName,
    required this.dayOfCleaning,
    required this.cleanerId,
  }) : super(key: key);

  @override
  _DateOfCleaningScreenState createState() => _DateOfCleaningScreenState();
}

class _DateOfCleaningScreenState extends State<DateOfCleaningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports for ${widget.dayOfCleaning} by ${widget.cleanerName}',
          style: const TextStyle(color: Color(0xFFF9C4B4)),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reports')
            .doc(widget.cleanerId) // Use the passed cleaner ID
            .collection('user_reports')
            .where('cleanername', isEqualTo: widget.cleanerName)
            .where('dayofcleaning', isEqualTo: widget.dayOfCleaning)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No reports found.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text('Date: ${data['dateofcleaning']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportDetailsScreen(
                        cleanerId: widget.cleanerId,
                        dayOfCleaning: widget.dayOfCleaning,
                        dateOfCleaning: data['dateofcleaning'], // Pass the date
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}