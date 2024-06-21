import 'package:flutter/material.dart';
import 'package:peachy/Customer/customerlogin.dart';

class Logout extends StatefulWidget {
  const Logout ({super.key});


  @override
  State<Logout > createState() => _LogoutState();
}

class _LogoutState extends State<Logout > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('"LOGOUT"'),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFF9C4B4),
          ), onPressed: () {
          Navigator.pop(context);
        },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextButton(
          onPressed: () {
            _logout(context);
          },
          child: const Text(
            "Logout",
            textAlign: TextAlign.left,
            style: TextStyle(
              color:  Color(0xFF111217),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
          child: const Text('Logout'),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  CustomerLogin()),
                  (route) => false,
            );
          },
          ),
        ],
      ),
    );
  }
}
