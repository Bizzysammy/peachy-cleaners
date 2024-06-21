import 'package:flutter/material.dart';
import 'package:peachy/Customer/customerhomepage.dart';
import 'package:peachy/Customer/livestream.dart';
import 'package:peachy/Customer/myorders.dart';
import 'package:peachy/Customer/messages.dart';

class Customerbottomnav extends StatefulWidget {


  const Customerbottomnav({Key? key, }) : super(key: key);

  @override
  CustomerbottomnavState createState() => CustomerbottomnavState();
}

class CustomerbottomnavState extends State<Customerbottomnav> {
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const customerhomepage( ), // Pass currentUser
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const customermyorders(), // Pass currentUser
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const customerlivestream(), // Pass currentUser
          ),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomerMessages(), // Pass currentUser
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
      selectedItemColor: const Color(0xFFF9C4B4),
      unselectedItemColor: const Color(0xFFF9C4B4),
      backgroundColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
