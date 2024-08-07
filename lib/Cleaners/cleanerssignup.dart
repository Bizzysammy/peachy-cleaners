import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:peachy/cleaners/cleanerslogin.dart';

class CleanersSignup extends StatefulWidget {
  const CleanersSignup({super.key});

  @override
  CleanersSignupState createState() => CleanersSignupState();
}

class CleanersSignupState extends State<CleanersSignup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cleanerIDController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void register(BuildContext context) async {
    String name = _nameController.text;
    String cleanerID = _cleanerIDController.text;
    String phoneNumber = _phoneNumberController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        cleanerID.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorSnackBar(context, 'All fields are required');
      return;
    }

    if (password != confirmPassword) {
      _showErrorSnackBar(context, 'Passwords do not match');
      return;
    }

    try {
      // Check if the name already exists in the Cleaners collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Cleaners')
          .where('name', isEqualTo: name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        _showErrorSnackBar(context, 'Entered name already exists');
        return;
      }

      // Proceed with registration if the name doesn't exist
      UserCredential customerCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('Cleaners')
          .doc(customerCredential.user!.uid)
          .set({
        'name': name,
        'CleanerID': cleanerID,
        'phoneNumber': phoneNumber,
        'email': email,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CleanersLogin()),
      );
    } catch (e) {
      _showErrorSnackBar(context, 'Registration failed: $e');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                width: size.width,
                height: size.height * 0.3,
                color: const Color(0xFFF9C4B4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'J & S ',
                      style: TextStyle(
                        fontSize: size.width * 0.1,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111217),
                      ),
                    ),
                    Text(
                      'Peachy Cleaners',
                      style: TextStyle(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111217),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    const Text(
                      "Cleaner's Signup",
                      style: TextStyle(
                        color: Color(0xFF111217),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                          hintStyle: const TextStyle(
                            color: Color(0xFF111217),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          hintStyle: const TextStyle(
                            color: Color(0xFF111217),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          hintStyle: const TextStyle(
                            color: Color(0xFF111217),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextField(
                        controller: _cleanerIDController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Cleaner ID NO.',
                          prefixIcon: Icon(Icons.credit_card),
                          hintStyle: const TextStyle(
                            color: Color(0xFF111217),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          hintStyle: const TextStyle(
                            color: Color(0xFF111217),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextField(
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                          hintStyle: const TextStyle(
                            color: Color(0xFF111217),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF111217),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CleanersLogin(),
                                ),
                                    (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                                vertical: size.height * 0.02,
                              ),
                              minimumSize: Size(
                                size.width * 0.3,
                                size.height * 0.05,
                              ),
                            ),
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF111217),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            'OR',
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF111217),
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          ElevatedButton(
                            onPressed: () {
                              register(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF9C4B4),
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                                vertical: size.height * 0.02,
                              ),
                              minimumSize: Size(
                                size.width * 0.3,
                                size.height * 0.05,
                              ),
                            ),
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF111217),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF9C4B4),
                          ),
                          children: [
                            TextSpan(
                              text: 'Log In',
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF111217),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CleanersLogin(),
                                    ),
                                        (route) => false,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
