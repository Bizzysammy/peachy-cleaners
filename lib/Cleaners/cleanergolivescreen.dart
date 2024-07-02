import 'package:flutter/material.dart';
import 'package:peachy/cleaner_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:peachy/Cleaners/cleanersbottomnav.dart';
import 'package:peachy/live/startlive.dart';


class cleanergolive extends StatefulWidget {
  const cleanergolive({Key? key}) : super(key: key);

  @override
  cleanergoliveState createState() => cleanergoliveState();
}

class cleanergoliveState extends State<cleanergolive> {
  final liveController = TextEditingController();

  @override
  void dispose() {
    liveController.dispose();
    super.dispose();
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        SizedBox(height: 20),
                        Text(
                          "Cleaners Go Live Screen",
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: liveController,
                    style: const TextStyle(fontSize: 25),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 70,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(size.width * 0.5, size.height * 0.07),
                      minimumSize: Size(size.width * 0.5, size.height * 0.07),
                      backgroundColor: const Color(0xFF111217),
                      foregroundColor: const Color(0xFFF9C4B4),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () async {
                      final cleanerAuthProvider = Provider.of<CleanerAuthProvider>(context, listen: false);
                      final cleanerName = await cleanerAuthProvider.getCleanerName();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveScreen1(
                            liveID: liveController.text,
                            userName: cleanerName,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Go Live',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const SizedBox(
                  height: 70,
                  width: 200,
                ),
              ],
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
