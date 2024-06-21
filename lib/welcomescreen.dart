import 'package:flutter/material.dart';
import 'package:peachy/customer/customerlogin.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return MaterialApp(
      title: 'J & S Peachy Cleaners',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF032B44)),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF111217), // very dark mix
                Color(0xFF1b2232), // somewhat dark mix
                Color(0xFF253863), // light mix
              ],
              stops: [
                0.0, // start with very dark mix
                0.7, // transition to somewhat dark mix in the middle
                1.0, // end with light mix
              ],
              begin: Alignment.bottomLeft, // start from bottom left
              end: Alignment.topRight, // end at top right
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenSize.height * 0.05),
                  Text(
                    'J & S ',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.2,
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
                  Center(
                    child: CircleAvatar(
                      radius: screenSize.width * 0.3,
                      backgroundImage: const AssetImage('assets/logo.jpg'),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                  Text(
                    '"Let us Hurt your Dirt"',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF9C4B4),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                  ElevatedButton(
                    onPressed: () {
    Navigator.of(context).push(
    PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>   CustomerLogin(),
    transitionDuration: const Duration(milliseconds: 5000),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
    final screenWidth = MediaQuery.of(context).size.width;

    final oldScreenLeft = Align(
    alignment: Alignment.centerLeft,
    child: SlideTransition(
    position: Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.0, 0.0),
    ).animate(animation),
    child: Container(
    width: screenWidth / 2,
    color: Colors.white,
    child: const WelcomeScreen(),
    ),
    ),
    );

    final oldScreenRight = Align(
    alignment: Alignment.centerRight,
    child: SlideTransition(
    position: Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.0, 0.0),
    ).animate(animation),
    child: Container(
    width: screenWidth / 2,
    color: Colors.white,
    child: const WelcomeScreen(),
    ),
    ),
    );

    final newScreen = FadeTransition(
    opacity: animation,
    child: child,
    );

    return Stack(
    children: <Widget>[
    oldScreenLeft,
    oldScreenRight,
    newScreen,
    ],
    );
    },
    ),
    );


  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD7BE),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.15,
                        vertical: screenSize.height * 0.03,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                      ),
                    ),
                    child: Text(
                      'START',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.08,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111217),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: screenSize.width * 0.03,
                        backgroundColor: const Color(0xFFF9C4B4),
                      ),
                      SizedBox(width: screenSize.width * 0.02),
                      CircleAvatar(
                        radius: screenSize.width * 0.03,
                        backgroundColor: const Color(0xFFF9C4B4),
                      ),
                      SizedBox(width: screenSize.width * 0.02),
                      CircleAvatar(
                        radius: screenSize.width * 0.03,
                        backgroundColor: const Color(0xFFF9C4B4),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
