import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminhomepage.dart';

class adminlogin extends StatelessWidget {
  const adminlogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Color(0xFFF9C4B4), // Set Scaffold background color to pink
      body: SafeArea(
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
                        color:  Color(0xFFF9C4B4),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xFFF9C4B4), // Background color for the remaining space
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "FOR ADMIN'S USE ONLY",
                        style: TextStyle(
                          color: const Color(0xFF111217),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminHomePage()),
                          );
                          // Add your onPressed logic here
                        },
                        child: const Text('Login'),
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
    final secondlastCurve = Offset(size.width-30, size.height - 20);
    path.quadraticBezierTo(secondfirstCurve.dx, secondfirstCurve.dy, secondlastCurve.dx, secondlastCurve.dy);


    final thirdfirstCurve = Offset(size.width, size.height - 20);
    final thirdlastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdfirstCurve.dx, thirdfirstCurve.dy, thirdlastCurve.dx, thirdlastCurve.dy);


    // Draw a curve from the top-right to the top-left, with a control point slightly above the middle of the widget
    path.lineTo(size.width, 0);
    path.close(); // Close the path
    return path; // Return the clip path
  }


  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
