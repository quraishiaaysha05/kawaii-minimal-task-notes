import 'package:flutter/material.dart';
import 'package:kawaii_habit_tracker/screens/home_screen.dart';

import '../constants/color.dart';
import '../constants/styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/b3.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset('assets/flowers.png', height:200),
                  Text(
                    'Welcome to Taskie!',
                    textAlign: TextAlign.center,
                    style: titleText,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your cute little helper for things you don\'t want to forget.',
                    textAlign: TextAlign.center,
                    style: bodyText,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Because remembering everything is hard… so write it down. Little things matter — let\'s track them together.',
                    textAlign: TextAlign.center,
                    style: bodyText,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: deepPink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    ),
                    child: Text('Let\'s Go!', style: subtitleText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
