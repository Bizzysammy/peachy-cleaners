import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';
import 'package:peachy/Admin/admincleanersmessages.dart';
import 'package:peachy/Admin/admingolive.dart';
import 'package:peachy/Admin/adminmyorder.dart';
import 'package:peachy/Admin/adminviewreports.dart';
import 'package:peachy/Admin/cleanerslist.dart';
import 'package:peachy/Admin/customerlist.dart';
import 'package:peachy/Admin/customermessages.dart';
import 'package:peachy/logoutscreen.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => AdminHomePageState();
}

class AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: const adminbottomnav(),
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
                                    builder: (context) => const Logout(),
                                  ),
                                );
                                // Handle menu icon tap
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.menu, color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                            const Column(
                              children: [
                                Text(
                                  'J & S',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF9C4B4),
                                  ),
                                ),
                                Text(
                                  'Peachy Cleaners',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF9C4B4),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const adminviewreports(),
                                  ),
                                );
                                // Handle settings icon tap
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.file_copy_sharp, color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        const Text(
                          "ADMIN",
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
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.18),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: size.width * 0.04,
                mainAxisSpacing: size.height * 0.02,
                childAspectRatio: 1, // Adjust this to change the button aspect ratio
                children: [
                  _buildSquareButton(
                    icon: Icons.shopping_cart,
                    text: "My Orders",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const adminmyorders (),
                        ),
                      );
                    },
                  ),
                  _buildSquareButton(
                    icon: Icons.live_tv,
                    text: "Live Stream",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const admingolive(),
                        ),
                      );
                    },
                  ),
                  _buildSquareButton(
                    icon: Icons.people,
                    text: "Customer List",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const customerlist(),
                        ),
                      );
                    },
                  ),
                  _buildSquareButton(
                    icon: Icons.cleaning_services,
                    text: "Cleaners List",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const cleanerslist(),
                        ),
                      );
                    },
                  ),
                  _buildSquareButton(
                    icon: Icons.message,
                    text: "Customer Messages",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const customermessages(),
                        ),
                      );
                    },
                  ),
                  _buildSquareButton(
                    icon: Icons.message_outlined,
                    text: "Cleaners Messages",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const admincleanersmessages(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSquareButton({required IconData icon, required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(40, 40), // Smaller button size
        foregroundColor: const Color(0xFFF9C4B4), // Text color
        backgroundColor: const Color(0xFF111217), // Button color
        padding: EdgeInsets.zero, // Remove default padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: const Color(0xFFF9C4B4)), // Smaller icon size
          const SizedBox(height: 18), // Reduced spacing
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18), // Smaller text size
          ),
        ],
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
