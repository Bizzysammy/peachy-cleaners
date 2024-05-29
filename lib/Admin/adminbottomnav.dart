import 'package:flutter/material.dart';
import 'package:peachy/Admin/admingolive.dart';
import 'package:peachy/Admin/adminhomepage.dart';
import 'package:peachy/Admin/adminmyorder.dart';
import 'package:peachy/Admin/adminnotifications.dart';


class adminbottomnav extends StatefulWidget {
  const adminbottomnav ({Key? key}) : super(key: key);

  @override
  adminbottomnavState createState() => adminbottomnavState();
}

class adminbottomnavState extends State<adminbottomnav> {
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
            builder: (context) => const AdminHomePage(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const adminmyorders(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const admingolive(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const adminnotification(),
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