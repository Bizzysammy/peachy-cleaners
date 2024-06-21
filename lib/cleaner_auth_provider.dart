import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CleanerAuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  String? _cleanerName; // Make cleanerName nullable

  CleanerAuthProvider() {
    _init();
  }

  void _init() {
    _auth.authStateChanges().listen((User? user) async {
      _user = user;
      if (_user != null) {
        await _loadCleanerData(); // Load cleaner data when user is logged in
      }
      notifyListeners();
    });
  }

  Future<void> _loadCleanerData() async {
    final cleanerDoc = await _firestore.collection('Cleaners')
        .doc(_user!.uid)
        .get();

    if (cleanerDoc.exists) {
      _cleanerName = cleanerDoc['name'] ?? 'No Name';
      print('Cleaner name loaded: $_cleanerName');
    } else {
      print('Cleaner document does not exist.');
    }
  }

  User? get currentUser => _user;

  bool get isLoggedIn => _user != null;

  // Use a getter that returns a Future<String>
  Future<String> getCleanerName() async {
    await _loadCleanerData(); // Ensure cleanerName is loaded before returning
    return _cleanerName ?? 'Unknown';
  }
}