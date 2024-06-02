import 'package:flutter/material.dart';

import 'package:peachy/welcomescreen.dart';


Future  main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        title: 'J & S Peachy Cleaners',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),

    );
  }
}
