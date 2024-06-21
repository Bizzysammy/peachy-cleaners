import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerAuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  String? _userName; // Make userName nullable

  CustomerAuthProvider() {
    _init();
  }

  void _init() {
    _auth.authStateChanges().listen((User? user) async {
      _user = user;
      if (_user != null) {
        await _loadUserData(); // Load user data when user is logged in
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserData() async {
    final userDoc = await _firestore.collection('Customers').doc(_user!.uid).get();

    if (userDoc.exists) {
      _userName = userDoc['name'] ?? 'No Name';
      print('User name loaded: $_userName');
    } else {
      print('User document does not exist.');
    }
  }

  User? get currentUser => _user;

  bool get isLoggedIn => _user != null;

  // Use a getter that returns a Future<String>
  Future<String> getCustomerName() async {
    await _loadUserData(); // Ensure userName is loaded before returning
    return _userName ?? 'Unknown';
  }
}