import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';



class admincleanersmessages extends StatefulWidget {
  const admincleanersmessages  ({Key? key}) : super(key: key);
  static const String id = 'admincleanersmessages';

  @override
  State<admincleanersmessages> createState() => admincleanersmessagesState();
}

class admincleanersmessagesState extends State<admincleanersmessages> {

  List<String> paymentmethod = ['VISA CARD', 'CASH', 'MOBILE MONEY'];
  String? payment;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cleaners messages',
          style: TextStyle(color: Color(0xFFF9C4B4)),
        ),
        centerTitle: true,
        flexibleSpace: Container(
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
        ),
      ),
      bottomNavigationBar: const adminbottomnav(),

    );
  }
}
