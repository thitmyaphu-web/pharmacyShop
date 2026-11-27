import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Chocochip Cake Shop';
  static const Color primaryColor = Color.fromARGB(255, 26, 56, 99);

  static const List<String> categories = [
    'All',
    'Fever & Pain',
    'Vitamins',
    'Antibiotics',
    'Allergy',
  ];

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 120, 167, 233),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color.fromARGB(208, 18, 109, 175),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 109, 94, 224),
      elevation: 0,
      centerTitle: false,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 31, 45, 78),
      elevation: 0,
      centerTitle: false,
    ),
  );
}