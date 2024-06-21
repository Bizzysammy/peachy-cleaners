import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:peachy/Cleaners/cleanersbottomnav.dart';
import 'package:peachy/Cleaners/cleanershomescreen.dart';
import 'package:peachy/cleaner_auth_provider.dart';

class CleanerReports extends StatefulWidget {
  @override
  State<CleanerReports> createState() => CleanerReportsState();
}

class CleanerReportsState extends State<CleanerReports> {
  TextEditingController cleanernameController = TextEditingController();
  TextEditingController dayofcleaningController = TextEditingController();
  TextEditingController dateofcleaningController = TextEditingController();
  TextEditingController customernameController = TextEditingController();
  TextEditingController numberofroomsController = TextEditingController();
  TextEditingController customeraddressController = TextEditingController();
  TextEditingController totalcashcollectionController = TextEditingController();
  TextEditingController totalvisacollectionController = TextEditingController();
  TextEditingController totalmobilemoneycollectionController = TextEditingController();
  TextEditingController totalcollectionController = TextEditingController();

  String? cleanerProfilePhotoURL; // To store the profile photo URL
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    totalcashcollectionController.addListener(_updateTotalCollection);
    totalvisacollectionController.addListener(_updateTotalCollection);
    totalmobilemoneycollectionController.addListener(_updateTotalCollection);

    // Fetch the cleaner name and profile photo URL in initState
    final cleanerAuthProvider = Provider.of<CleanerAuthProvider>(context, listen: false);
    cleanerAuthProvider.getCleanerName().then((cleanerName) {
      setState(() {
        cleanernameController.text = cleanerName;
      });
      _loadUserProfilePicture(cleanerName);
    });
  }

  Future<void> _loadUserProfilePicture(String cleanerName) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('Cleaners')
          .where('name', isEqualTo: cleanerName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot userDoc = querySnapshot.docs.first;
        setState(() {
          cleanerProfilePhotoURL = userDoc['profile_photo'] ?? 'https://example.com/default-profile-picture.png';
        });
        print('User profile picture loaded: $cleanerProfilePhotoURL');
      } else {
        print('No matching cleaner found.');
      }
    } catch (error) {
      print('Error fetching profile photo: $error');
    }
  }

  @override
  void dispose() {
    totalcashcollectionController.removeListener(_updateTotalCollection);
    totalvisacollectionController.removeListener(_updateTotalCollection);
    totalmobilemoneycollectionController.removeListener(_updateTotalCollection);
    totalcashcollectionController.dispose();
    totalvisacollectionController.dispose();
    totalmobilemoneycollectionController.dispose();
    totalcollectionController.dispose();
    super.dispose();
  }

  void _updateTotalCollection() {
    double cash = double.tryParse(totalcashcollectionController.text) ?? 0.0;
    double visa = double.tryParse(totalvisacollectionController.text) ?? 0.0;
    double mobileMoney = double.tryParse(totalmobilemoneycollectionController.text) ?? 0.0;
    double total = cash + visa + mobileMoney;

    totalcollectionController.text = total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final cleanerAuthProvider = Provider.of<CleanerAuthProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
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
          title: const Text(
            "Write Report",
            style: TextStyle(
              color: Color(0xFFF9C4B4),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CleanersHomePage(),
                  ),
                );
              },
              child: const Text(
                "Back",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFF9C4B4),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                String cleanerName = await cleanerAuthProvider.getCleanerName();
                _saveReport(cleanerName);
              },
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFF9C4B4),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Cleanersbottomnav(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildTextField(
                controller: cleanernameController,
                hintText: 'Cleaner Name',
                enabled: false,
              ),
              const SizedBox(height: 11),
              _buildTextField(
                controller: dayofcleaningController,
                hintText: 'Day of Cleaning',
              ),
              const SizedBox(height: 11),
              _buildTextField(
                controller: dateofcleaningController,
                hintText: 'Date of Cleaning',
              ),
              const SizedBox(height: 11),
              _buildTextField(
                controller: customernameController,
                hintText: 'Customer Name',
              ),
              const SizedBox(height: 11),
              _buildTextField(
                controller: numberofroomsController,
                hintText: 'Number of Rooms',
              ),
              const SizedBox(height: 11),
              _buildTextField(
                controller: customeraddressController,
                hintText: 'Customer Address',
              ),
              const SizedBox(height: 11),
              _buildTextField(
                controller: totalcashcollectionController,
                hintText: 'Total Cash Collection',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 11),
              _buildTextField(
                controller: totalvisacollectionController,
                hintText: 'Total Visa Collection',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 11),
              _buildTextField(
                controller: totalmobilemoneycollectionController,
                hintText: 'Total MobileMoney Collection',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 11),
              _buildTextField(
                controller: totalcollectionController,
                hintText: 'Total Collection',
                keyboardType: TextInputType.number,
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
    // Remove initialValue as it's handled in initState
  }) {
    return Container(
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }

  void _saveReport(String cleanerName) async {
    try {
      // Get current user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated.');
      }

      // Create a reference to the Firestore database
      final firestore = FirebaseFirestore.instance;

      // Prepare data to save
      Map<String, dynamic> reportData = {
        'cleanername': cleanerName,
        'dayofcleaning': dayofcleaningController.text,
        'dateofcleaning': dateofcleaningController.text,
        'customername': customernameController.text,
        'numberofrooms': numberofroomsController.text,
        'customeraddress': customeraddressController.text,
        'totalcashcollection': double.tryParse(totalcashcollectionController.text) ?? 0.0,
        'totalvisacollection': double.tryParse(totalvisacollectionController.text) ?? 0.0,
        'totalmobilemoneycollection': double.tryParse(totalmobilemoneycollectionController.text) ?? 0.0,
        'totalcollection': double.tryParse(totalcollectionController.text) ?? 0.0,
        'timestamp': FieldValue.serverTimestamp(),
        'profile_photo': cleanerProfilePhotoURL, // Store the photo URL
      };

      // Save report to Firestore
      await firestore.collection('reports').doc(user.uid).collection('user_reports').add(reportData);

      // Clear text field controllers
      dayofcleaningController.clear();
      dateofcleaningController.clear();
      customernameController.clear();
      numberofroomsController.clear();
      customeraddressController.clear();
      totalcashcollectionController.clear();
      totalvisacollectionController.clear();
      totalmobilemoneycollectionController.clear();
      totalcollectionController.clear();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report saved successfully.'),
          duration: Duration(seconds: 2), // Adjust duration as needed
        ),
      );

      // Navigate back to Home or do any other post-save actions
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CleanersHomePage()));
    } catch (error) {
      print('Error saving report: $error');
      // Handle error accordingly, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save report. Please try again later.'),
          duration: Duration(seconds: 2), // Adjust duration as needed
        ),
      );
    }
  }
}
