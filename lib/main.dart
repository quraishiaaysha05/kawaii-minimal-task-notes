import 'package:flutter/material.dart';
import 'package:kawaii_habit_tracker/screens/welcome.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskie',
      debugShowCheckedModeBanner: false,
      
      home: WelcomeScreen(),
    );
  }
}
