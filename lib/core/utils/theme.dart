import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/colors.dart';

final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: orange, // Основной цвет (будет использован вместо accentColor)
      secondary: Color(0xFFAB8A74), // Вторичный цвет, если вам нужен
      surface: white, // Цвет поверхности (например, фон карточек)
      error: Color(0xFFFF5449), // Цвет для ошибок
      onPrimary: Color(0xFFFFFFFF), // Цвет текста на основном фоне
      onSecondary: Color(0xFFFFFFFF), // Цвет текста на вторичном фоне
      onSurface: Color(0xFF221a15), // Цвет текста на поверхности
      onError: Color(0xFFFFFFFF), // Цвет текста на фоне ошибки
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Colors.white, // Цвет фона навбара
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: white),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(color: greyColor),
    outlinedButtonTheme: const OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:WidgetStatePropertyAll(backgroundInputButton), // Цвет фона
        side: WidgetStatePropertyAll(BorderSide(color: Colors.transparent)), // Цвет границы
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)), // Закругление углов
          ),
        ),
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
