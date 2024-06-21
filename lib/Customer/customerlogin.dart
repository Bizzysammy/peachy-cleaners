import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminlogin.dart';
import 'package:peachy/Customer/customerforgotpassword.dart';
import 'package:peachy/Customer/customerhomepage.dart';

import 'package:peachy/customer/customersignup.dart';
import 'package:peachy/welcomescreen.dart';

import '../Cleaners/cleanerslogin.dart';

class CustomerLogin extends StatelessWidget {
  CustomerLogin({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      // Show circular progress indicator while logging in
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Customers')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Remove the progress indicator
        Navigator.pop(context);

        _showErrorSnackBar(context, 'User not found, only customers can login here');
        return;
      }
      // Sign in the user with Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Remove the progress indicator
      Navigator.pop(context);

      // Navigate to the home page
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const customerhomepage(),
          transitionDuration: const Duration(milliseconds: 8000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final explodeAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
            );

            final fadeInAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
            );

            final oldScreen = Stack(
              children: [
                _buildExplodingPiece(context, explodeAnimation, Alignment.topLeft),
                _buildExplodingPiece(context, explodeAnimation, Alignment.topRight),
                _buildExplodingPiece(context, explodeAnimation, Alignment.bottomLeft),
                _buildExplodingPiece(context, explodeAnimation, Alignment.bottomRight),
              ],
            );

            final newScreen = FadeTransition(
              opacity: fadeInAnimation,
              child: child,
            );

            return Stack(
              children: <Widget>[
                oldScreen,
                newScreen,
              ],
            );
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Remove the progress indicator
      Navigator.pop(context);

      // Show error message to the user
      if (e.code == 'user-not-found') {
        _showErrorSnackBar(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        _showErrorSnackBar(context, 'Wrong password');
      } else {
        _showErrorSnackBar(
            context, 'Check your password and email and login again.');
      }
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
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9C4B4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: BottomCurveClipper(),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.4,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF111217),
                            Color(0xFF1b2232),
                            Color(0xFF253863),
                          ],
                          stops: [0.0, 0.5, 1.0],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: screenSize.height * 0.01),
                          Text(
                            'J & S',
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
                            "Customer's Login",
                            style: TextStyle(
                              color: Color(0xFFF9C4B4),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF9C4B4),
                              foregroundColor: const Color(0xFF111217),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const customersignup()),
                              );
                            },
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                              (route) => false,
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, color: Color(0xFFF9C4B4)),
                          const SizedBox(width: 8),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFF9C4B4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AdminLogin()),
                  );
                },
                child: Text(
                  ' ADMIN ',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111217),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CleanersLogin()),
                  );
                },
                child: Text(
                  ' CLEANERS ',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111217),
                  ),
                ),
              ),
              Container(
                color: const Color(0xFFF9C4B4),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color(0xFF111217),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(size.width * 0.5, size.height * 0.07),
                        minimumSize: Size(size.width * 0.5, size.height * 0.07),
                        backgroundColor: const Color(0xFF111217),
                        foregroundColor: const Color(0xFFF9C4B4),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        login(context, _emailController.text, _passwordController.text);
                      },
                      child: const Text('Login'),
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  CustomerForgotPassword(),
                          ),
                        );
                        // Navigate to forgot password page
                      },
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF111217),
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

  Widget _buildExplodingPiece(BuildContext context, Animation<double> animation, Alignment alignment) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: Offset(
          alignment.x * screenWidth * animation.value,
          alignment.y * screenHeight * animation.value,
        ),
        child: SizedBox(
          width: screenWidth / 2,
          height: screenHeight / 2,
          child: const WelcomeScreen(),
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
