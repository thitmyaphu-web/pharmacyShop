import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Medi Shop';
  static const Color primaryColor = Color(0xFF0E7C7B);

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
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFF6F9F8),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF6F9F8),
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
      backgroundColor: Color(0xFF0F172A),
      elevation: 0,
      centerTitle: false,
    ),
  );
}