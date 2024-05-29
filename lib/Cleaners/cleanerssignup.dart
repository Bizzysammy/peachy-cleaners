import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:peachy/cleaners/cleanerslogin.dart';


class cleanerssignup extends StatefulWidget {
  const cleanerssignup({super.key});

  @override
  cleanerssignupState createState() => cleanerssignupState();
}

class cleanerssignupState extends State<cleanerssignup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cleanerIDController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                        color:  Color(0xFF111217),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              // Background color for the remaining space
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
                        keyboardType: TextInputType.text ,
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
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
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
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock),
                          alignLabelWithHint: true,
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
                                  builder: (context) => const cleanerslogin(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const cleanerslogin()),
                              );
                              // Handle signup logic here
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
                                      builder: (context) => const cleanerslogin(),
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
