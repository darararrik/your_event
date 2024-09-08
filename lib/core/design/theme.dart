import 'package:flutter/material.dart';
import 'package:yourevent/core/design/colors.dart';

final lightTheme = ThemeData(
    primaryColor: orange,
    scaffoldBackgroundColor: Colors.white,
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Colors.white, // Цвет фона навбара
      indicatorColor: orange,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: white),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 26,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      //H2
      headlineMedium: TextStyle(
        fontSize: 22,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
         fontSize: 18,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 15,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),

    ));
