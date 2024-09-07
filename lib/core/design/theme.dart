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
      //H1
      bodyLarge: TextStyle(
        fontSize: 26,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),

      //H2
      bodyMedium: TextStyle(
        fontSize: 22,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),

      //H3
      headlineMedium: TextStyle(
        fontSize: 20,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),

      //H6
      labelMedium: TextStyle(
        fontSize: 15,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      //Paragraph 1
      bodySmall: TextStyle(
        fontSize: 16,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),

      //Paragraph 3
      labelSmall: TextStyle(
        fontSize: 14,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),

      //Action Button
      titleMedium: TextStyle(
        fontSize: 18,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ));
