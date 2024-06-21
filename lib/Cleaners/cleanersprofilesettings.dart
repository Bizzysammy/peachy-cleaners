import 'package:flutter/material.dart';
import 'package:peachy/Cleaners/cleanersbottomnav.dart';
import 'package:peachy/Cleaners/cleanershomescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class cleanerprofilesetting extends StatefulWidget {
  const cleanerprofilesetting({Key? key}) : super(key: key);

  @override
  State<cleanerprofilesetting> createState() => cleanerprofilesettingState();
}

class cleanerprofilesettingState extends State<cleanerprofilesetting> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  User? _user;
  String? _userName;
  String? _userEmail;
  File? _imageFile;
  String? _newPassword;
  String? imageUrl;

  // Add TextEditingControllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _loadUserData();
    _loadProfileImage(); // Load the profile image initially

    // Initialize TextEditingControllers
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final DocumentSnapshot userDoc =
    await _firestore.collection('Cleaners').doc(_user!.uid).get();

    setState(() {
      _userName = userDoc['name'];
      _userEmail = _user!.email;

      // Set initial values for controllers
      _nameController.text = _userName ?? '';
      _emailController.text = _userEmail ?? '';
    });
  }

  Future<void> _loadProfileImage() async {
    final userDoc = await _firestore.collection('Cleaners').doc(_user!.uid).get();
    final profileImageUrl = userDoc['profile_photo'];

    setState(() {
      imageUrl = profileImageUrl;
    });
  }

  Future<void> _updateProfile() async {
    try {
      if (_userName != null) {
        await _firestore
            .collection('Cleaners')
            .doc(_user!.uid)
            .update({'name': _userName});
      }
      if (_imageFile != null) {
        final String fileName = 'profile_${_user!.uid}.jpg';
        final Reference storageRef = _storage.ref().child(fileName);
        await storageRef.putFile(_imageFile!);
        final String newImageUrl = await storageRef.getDownloadURL();
        await _firestore
            .collection('Cleaners')
            .doc(_user!.uid)
            .update({'profile_photo': newImageUrl});

        // Update the imageUrl variable and trigger a rebuild
        setState(() {
          imageUrl = newImageUrl;
        });
      }
      if (_newPassword != null) {
        await _user!.updatePassword(_newPassword!);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  Future<void> _gallery() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _camera() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.camera, // Change to ImageSource.camera
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const Cleanersbottomnav(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.3,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CleanersHomePage()),
                                );
                                // Handle menu icon tap
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_back_rounded, color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                            const Text(
                              "Profile Settings",
                              style: TextStyle(
                                color: Color(0xFFF9C4B4),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _updateProfile();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.save, color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Profile Picture"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.photo_camera),
                                        title: const Text("Take a Photo"),
                                        onTap: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          _camera();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo),
                                        title: const Text("Choose from Gallery"),
                                        onTap: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          _gallery();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: imageUrl != null
                                ? NetworkImage(imageUrl!)
                                : const AssetImage('assets/logo.jpg')
                            as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person, color: Color(0xFF111217)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _userName = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Color(0xFF111217)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _userEmail = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF111217)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _newPassword = value;
                  });
                },
                obscureText: true,
              ),
            ),
          ],
        ),
      ),



    );
  }
}


class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondFirstCurve = Offset(0, size.height - 20);
    final secondLastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy, secondLastCurve.dx, secondLastCurve.dy);

    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy, thirdLastCurve.dx, thirdLastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
