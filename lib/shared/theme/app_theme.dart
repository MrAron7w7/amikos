import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();
  static ThemeData lightMode() => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade300,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.grey.shade300,
          foregroundColor: Colors.grey.shade500,
        ),
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade300,
          primary: Colors.grey.shade500,
          secondary: Colors.grey.shade200,
          tertiary: Colors.white,
          inversePrimary: Colors.grey.shade900,
        ),
      );

  static ThemeData darkMode() => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          foregroundColor: Color.fromARGB(255, 105, 105, 105),
          scrolledUnderElevation: 0.0,
          centerTitle: true,
        ),
        colorScheme: ColorScheme.dark(
          surface: const Color.fromARGB(255, 20, 20, 20),
          primary: const Color.fromARGB(255, 105, 105, 105),
          secondary: const Color.fromARGB(255, 30, 30, 30),
          tertiary: const Color.fromARGB(255, 47, 47, 47),
          inversePrimary: Colors.grey.shade300,
        ),
      );
}
