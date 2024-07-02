import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminhomepage.dart';

class AdminLogin extends StatefulWidget {
  AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

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
                        "Admin's Login",
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
                      "FOR ADMIN'S USE ONLY",
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
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
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
                        border: const OutlineInputBorder(
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

Future<void> login(BuildContext context, String email, String password) async {
  // Validate the email and password
  if (email.trim().isEmpty || password.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter email and password')),
    );
    return;
  }

  try {
    // Show circular progress indicator while logging in
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // Query the "admins" collection to check the credentials
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('admins')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // Remove the progress indicator
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
      return;
    }

    DocumentSnapshot adminSnapshot = querySnapshot.docs.first;

    // Retrieve the admin data
    Map<String, dynamic>? adminData = adminSnapshot.data() as Map<String, dynamic>?;

    if (adminData == null || adminData['password'] != password) {
      // Remove the progress indicator
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
      return;
    }

    // Remove the progress indicator
    Navigator.pop(context);

    // Navigate to the home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomePage()),
    );
  } catch (e) {
    // Remove the progress indicator
    Navigator.pop(context);

    // Show error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An error occurred. Please try again later.')),
    );
  }
}
