import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(backgroundColor: Colors.white),
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple, background: Colors.white),
  useMaterial3: true,
);
