import 'package:flutter/material.dart';
import 'package:peachy/Customer/customerbottomnav.dart';
import 'package:peachy/Customer/customerhomepage.dart';


class customerprofilesetting extends StatefulWidget {
  const customerprofilesetting({Key? key}) : super(key: key);

  @override
  State<customerprofilesetting> createState() => customerprofilesettingState();
}

class customerprofilesettingState extends State<customerprofilesetting> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const Customerbottomnav(),
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
                            builder: (context) => const customerhomepage()),
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
                      // Handle settings icon tap
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

                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text("Choose from Gallery"),
                              onTap: () {

                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/person.jpg'),
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
    decoration: const InputDecoration(
                labelText: 'Name',
    prefixIcon: Icon(Icons.person, color: Color(0xFF111217)),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
              ),
              onChanged: (value) {
                setState(() {

                });
              },
            ),
    ),
    Padding(
    padding: const EdgeInsets.all(3),
    child: TextField(
    decoration: const InputDecoration(
                labelText: 'Email',
    prefixIcon: Icon(Icons.email, color: Color(0xFF111217)),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    ),
              onChanged: (value) {
                setState(() {

                });
              },
            ),
    ),
      Padding(
        padding: const EdgeInsets.all(3),
        child: TextField(
          decoration: const InputDecoration(
                labelText: 'New Password',
    prefixIcon: Icon(Icons.lock, color: Color(0xFF111217)),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    ),
              onChanged: (value) {
                setState(() {

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
