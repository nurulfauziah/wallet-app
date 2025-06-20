import 'package:flutter/material.dart';
import 'package:wallet_app/core/theme/light_theme.dart';
import 'package:wallet_app/core/theme/dark_theme.dart';

class AppTheme {
  static ThemeData getLightTheme() => lightTheme;
  static ThemeData getDarkTheme() => darkTheme;
}

extension CustomColorScheme on ColorScheme {
  Color get linkColor =>
      brightness == Brightness.dark ? Colors.tealAccent : Colors.blue;
}
