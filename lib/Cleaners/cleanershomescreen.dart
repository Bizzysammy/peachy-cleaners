import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peachy/Cleaners/cleanergolivescreen.dart';
import 'package:peachy/Cleaners/cleanersbottomnav.dart';
import 'package:peachy/Cleaners/cleanersmessages.dart';
import 'package:peachy/Cleaners/cleanersmyorders.dart';
import 'package:peachy/Cleaners/cleanersprofilesettings.dart';
import 'package:peachy/Cleaners/cleanersreports.dart';
import 'package:peachy/logoutscreen.dart';

class CleanersHomePage extends StatefulWidget {
  const CleanersHomePage({Key? key}) : super(key: key);

  @override
  State<CleanersHomePage> createState() => CleanersHomePageState();
}

class CleanersHomePageState extends State<CleanersHomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser;
  String? userName;
  String? userProfilePicture;
  String? cleanerID;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadUserProfilePicture();
  }

  Future<void> _loadUserData() async {
    currentUser = _auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot userDoc = await _firestore.collection('Cleaners').doc(currentUser!.uid).get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'] ?? 'No Name';
          cleanerID = userDoc['CleanerID'] ?? 'No CleanerID';
        });
        print('User name loaded: $userName');
        print('CleanerID loaded: $cleanerID');
      } else {
        print('User document does not exist.');
      }
    } else {
      print('No user is logged in.');
    }
  }

  Future<void> _loadUserProfilePicture() async {
    currentUser = _auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot userDoc = await _firestore.collection('Cleaners').doc(currentUser!.uid).get();

      if (userDoc.exists) {
        setState(() {
          userProfilePicture = userDoc['profile_photo'] ?? 'https://example.com/default-profile-picture.png';
        });
        print('User profile picture loaded: $userProfilePicture');
      } else {
        print('User document does not exist.');
      }
    } else {
      print('No user is logged in.');
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
                                      builder: (context) => const Logout()),
                                );
                                // Handle menu icon tap
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.menu, color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: userProfilePicture != null
                                  ? NetworkImage(userProfilePicture!)
                                  : const AssetImage('assets/person.jpg')
                              as ImageProvider,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const cleanerprofilesetting()),
                                );
                                // Handle settings icon tap
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.settings, color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          userName ?? "Cleaner Name",
                          style: const TextStyle(
                            color: Color(0xFFF9C4B4),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: const Text(
                      "CLEANER",
                      style: TextStyle(
                        color: Color(0xFFF9C4B4),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CleanerID: ${cleanerID ?? "No CleanerID"}',
                    style: const TextStyle(
                      color:  Color(0xFF111217),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: size.width * 0.05,
                    mainAxisSpacing: size.height * 0.02,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF111217), // Text color
                          backgroundColor: const Color(0xFFF9C4B4), // Button color
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const cleanersmyorders()),
                          );

                        },
                        child: const Text("My Orders"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF111217), // Text color
                          backgroundColor: const Color(0xFFF9C4B4), // Button color
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const cleanergolive()),
                          );

                        },
                        child: const Text("Go Live"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF111217), // Text color
                          backgroundColor: const Color(0xFFF9C4B4), // Button color
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  CleanerReports()),
                          );

                        },
                        child: const Text("Reports"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF111217), // Text color
                          backgroundColor: const Color(0xFFF9C4B4), // Button color
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const CleanerMessages()),
                          );

                        },
                        child: const Text("Messages"),
                      ),
                    ],
                  ),
                ],
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
