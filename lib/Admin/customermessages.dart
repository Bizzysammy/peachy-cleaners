import 'package:flutter/material.dart';
import 'package:peachy/Admin/adminbottomnav.dart';



class customermessages extends StatefulWidget {
  const customermessages  ({Key? key}) : super(key: key);
  static const String id = 'customermessages';

  @override
  State<customermessages> createState() => customermessagesState();
}

class customermessagesState extends State<customermessages> {

  List<String> paymentmethod = ['VISA CARD', 'CASH', 'MOBILE MONEY'];
  String? payment;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer messages',
          style: TextStyle(color: Color(0xFFF9C4B4)),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D1F2D), // very dark mix
                Color(0xFF23313D), // somewhat dark mix
                Color(0xFF455A64), // light mix
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
