import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerAuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  String? _userName;
  String? _phoneNumber;

  CustomerAuthProvider() {
    _init();
  }

  void _init() {
    _auth.authStateChanges().listen((User? user) async {
      _user = user;
      if (_user != null) {
        await _loadUserData();
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserData() async {
    final userDoc = await _firestore.collection('Customers').doc(_user!.uid).get();

    if (userDoc.exists) {
      _userName = userDoc['name'] ?? 'No Name';
      _phoneNumber = userDoc['phoneNumber'] ?? 'No Phone Number';
      print('User data loaded: $_userName, $_phoneNumber');
    } else {
      print('User document does not exist.');
    }
  }

  User? get currentUser => _user;

  bool get isLoggedIn => _user != null;

  Future<String> getCustomerName() async {
    await _loadUserData();
    return _userName ?? 'Unknown';
  }

  Future<String> getPhoneNumber() async {
    await _loadUserData();
    return _phoneNumber ?? 'Unknown';
  }
}