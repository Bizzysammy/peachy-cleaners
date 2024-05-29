import 'package:flutter/material.dart';
import 'package:peachy/Customer/customerbottomnav.dart';


class customermyorders extends StatefulWidget {
  const customermyorders({Key? key}) : super(key: key);
  static const String id = 'customermyorders';

  @override
  State<customermyorders> createState() => customermyordersState();
}

class customermyordersState extends State<customermyorders> {

  List<String> paymentmethod = ['VISA CARD', 'CASH', 'MOBILE MONEY'];
  String? payment;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
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
      bottomNavigationBar: const Customerbottomnav(),

    );
  }
}
