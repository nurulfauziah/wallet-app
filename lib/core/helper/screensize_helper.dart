import 'package:flutter/material.dart';

class ScreenSizeHelper {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isSmallPhone(BuildContext context) {
    return width(context) < 360 || height(context) < 650; // HP kecil
  }

  static bool isMediumPhone(BuildContext context) {
    return (width(context) >= 360 && width(context) < 600) &&
        (height(context) >= 650 && height(context) < 800);
  }

  static bool isLargePhone(BuildContext context) {
    return width(context) >= 600 ||
        height(context) >= 800; // Tablet atau layar besar
  }
}
