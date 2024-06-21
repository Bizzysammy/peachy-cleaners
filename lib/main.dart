import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'customer_auth_provider.dart'; // Import your customer auth provider
import 'cleaner_auth_provider.dart'; // Import your cleaner auth provider
import 'welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomerAuthProvider>(
          create: (context) => CustomerAuthProvider(),
        ),
        ChangeNotifierProvider<CleanerAuthProvider>(
          create: (context) => CleanerAuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'J & S Peachy Cleaners',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
