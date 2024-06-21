import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerForgotPassword extends StatefulWidget {
  CustomerForgotPassword({Key? key}) : super(key: key);

  @override
  _CustomerForgotPasswordState createState() => _CustomerForgotPasswordState();
}

class _CustomerForgotPasswordState extends State<CustomerForgotPassword> {
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _resetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text.trim();
      String newPassword = _newPasswordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('New password and confirm password do not match'),
        ));
        return;
      }

      try {
        // Check if the email exists in the 'cleaners' collection
        QuerySnapshot querySnapshot = await _firestore
            .collection('Customers')
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email not found'),
          ));
          return;
        }

        // Send password reset email
        await _auth.sendPasswordResetEmail(email: email);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password reset email sent. Please check your inbox.'),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to send password reset email: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9C4B4), // Set Scaffold background color to pink
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  width: size.width,
                  height: size.height * 0.4,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF111217), // very dark mix
                        Color(0xFF1b2232), // somewhat dark mix
                        Color(0xFF253863), // light mix
                      ],
                      stops: [
                        0.0, // start with very dark mix
                        0.5, // transition to somewhat dark mix in the middle
                        1.0, // end with light mix
                      ],
                      begin: Alignment.bottomLeft, // start from bottom left
                      end: Alignment.topRight, // end at top right
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenSize.height * 0.01),
                      Text(
                        'J & S ',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.1,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF9C4B4),
                        ),
                      ),
                      Text(
                        'Peachy Cleaners',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF9C4B4),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.05),
                      const Text(
                        "Customers Forgot Password",
                        style: TextStyle(
                          color: Color(0xFFF9C4B4),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: const Color(0xFFF9C4B4), // Background color for the remaining space
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "let us hurt your dirt",
                      style: TextStyle(
                        color: Color(0xFF111217),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _newPasswordController,
                              decoration: const InputDecoration(labelText: 'New Password'),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a new password';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              decoration: const InputDecoration(labelText: 'Confirm Password'),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your new password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _resetPassword,
                              child: const Text('Reset Password'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

    final secondfirstCurve = Offset(0, size.height - 20);
    final secondlastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondfirstCurve.dx, secondfirstCurve.dy, secondlastCurve.dx, secondlastCurve.dy);

    final thirdfirstCurve = Offset(size.width, size.height - 20);
    final thirdlastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdfirstCurve.dx, thirdfirstCurve.dy, thirdlastCurve.dx, thirdlastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
