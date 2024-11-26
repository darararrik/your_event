import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/colors.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: _colorShcemeTheme(),
  tabBarTheme: _tabBarTheme(),
  navigationBarTheme: _navigationBarThemeData(),
  appBarTheme: _appBarTheme(),
  textButtonTheme: _textButtonThemeData(),
  iconTheme: _iconThemeData(),
  outlinedButtonTheme: _outlinedButtonTheme(),
  textTheme: _textTheme(),
);

//lightTheme
TabBarTheme _tabBarTheme() {
  return const TabBarTheme(
      labelColor: orange, // Цвет выделенной вкладки
      unselectedLabelColor: Colors.grey, // Цвет невыделенной вкладки
      indicatorColor: orange, // Цвет линии под вкладкой
      dividerColor: grey,
      dividerHeight: 0.5, // Стиль текста для активной вкладки
      unselectedLabelStyle:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: grey),
      labelStyle: TextStyle(
        fontSize: 14,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        color: orange,
      ));
}

NavigationBarThemeData _navigationBarThemeData() {
  return const NavigationBarThemeData(
    backgroundColor: Colors.white, // Цвет фона навбара
    indicatorColor: Colors.transparent,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
  );
}

AppBarTheme _appBarTheme() => const AppBarTheme(backgroundColor: white);

TextButtonThemeData _textButtonThemeData() {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
    ),
  );
}

IconThemeData _iconThemeData() => const IconThemeData(color: greyColor);

OutlinedButtonThemeData _outlinedButtonTheme() {
  return const OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStatePropertyAll(backgroundInputButton), // Цвет фона
      side: WidgetStatePropertyAll(
          BorderSide(color: Colors.transparent)), // Цвет границы
      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(10)), // Закругление углов
        ),
      ),
    ),
  );
}

TextTheme _textTheme() {
  return const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 26,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
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
  );
}

ColorScheme _colorShcemeTheme() {
  return const ColorScheme.light(
    primary: white, // Основной цвет (будет использован вместо accentColor)
    secondary: Color(0xFFAB8A74), // Вторичный цвет, если вам нужен
    surface: white, // Цвет поверхности (например, фон карточек)
    error: Color(0xFFFF5449), // Цвет для ошибок
    onPrimary: Color(0xFFFFFFFF), // Цвет текста на основном фоне
    onSecondary: Color(0xFFFFFFFF), // Цвет текста на вторичном фоне
    onSurface: Color(0xFF221a15), // Цвет текста на поверхности
    onError: Color(0xFFFFFFFF), // Цвет текста на фоне ошибки
  );
}

extension ThemePlatformExtension on ThemeData {
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  Color get cupertinoAlertColor => const Color(0xFFF82B10);
  Color get cupertinoActionColor => const Color(0xFF3478F7);
}
