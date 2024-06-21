import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peachy/Admin/dateofcleaningscreen.dart';

class DayOfCleaningScreen extends StatefulWidget {
  final String cleanerName;

  const DayOfCleaningScreen({Key? key, required this.cleanerName}) : super(key: key);

  @override
  _DayOfCleaningScreenState createState() => _DayOfCleaningScreenState();
}

class _DayOfCleaningScreenState extends State<DayOfCleaningScreen> {
  late Future<String?> cleanerIdFuture;

  @override
  void initState() {
    super.initState();
    cleanerIdFuture = _getCleanerId(widget.cleanerName);
  }

  Future<String?> _getCleanerId(String cleanerName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Cleaners')
        .where('name', isEqualTo: cleanerName)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Days of Cleaning for ${widget.cleanerName}',
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
      body: FutureBuilder<String?>(
        future: cleanerIdFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Cleaner not found.'));
          }

          final cleanerId = snapshot.data!;

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('reports') // Main collection
                .doc(cleanerId) // Cleaner's document
                .collection('user_reports') // Subcollection
                .snapshots(), // Stream of updates
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No cleaning days found.'));
              }
              final reports = snapshot.data!.docs;
              final days = reports
                  .map((doc) => doc['dayofcleaning'] as String)
                  .toSet()
                  .toList(); // Extract unique day of cleaning

              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DateOfCleaningScreen(
                            cleanerName: widget.cleanerName,
                            dayOfCleaning: day,
                            cleanerId: cleanerId, // Pass the cleaner ID to DateOfCleaningScreen
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9C4B4), // Button background color
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      day,
                      style: const TextStyle(color: Color(0xFF111217)),
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