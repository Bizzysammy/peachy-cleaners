import 'package:flutter/material.dart';
import 'package:peachy/Cleaners/cleanergolivescreen.dart';
import 'package:peachy/Cleaners/cleanernotifications.dart';
import 'package:peachy/Cleaners/cleanershomescreen.dart';
import 'package:peachy/Cleaners/cleanersmyorders.dart';


class Cleanersbottomnav extends StatefulWidget {
  const Cleanersbottomnav ({Key? key}) : super(key: key);

  @override
  CleanersbottomnavState createState() => CleanersbottomnavState();
}

class CleanersbottomnavState extends State<Cleanersbottomnav > {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      _navigateToScreen(index);
    });
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CleanersHomePage(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const cleanersmyorders(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const cleanergolive(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const cleanernotification(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.live_tv_rounded),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'My Orders',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFFF9C4B4),
      unselectedItemColor: Color(0xFFF9C4B4),
      backgroundColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}