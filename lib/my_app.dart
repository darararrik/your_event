import 'package:flutter/material.dart';
import 'package:yourevent/design/Theme.dart';
import 'package:yourevent/screens/home/home_screen.dart';
import 'package:yourevent/screens/signIn/signIn_screen.dart';
import 'package:yourevent/screens/signUp/signUp_screen.dart';
import 'package:yourevent/screens/start/start_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/start': (context) => StartScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/signIn': (context) => SignInScreen(),
      },
      home: StartScreen(),
    );
  }
}
