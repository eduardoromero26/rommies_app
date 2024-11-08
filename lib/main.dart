import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roomies_app/firebase_options.dart';
import 'package:roomies_app/screens/home/home_screen.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rommies App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 69, 125),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
