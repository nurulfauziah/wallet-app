import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextStyle({
  required BuildContext context,
  required double fontSize,
  FontWeight fontWeight = FontWeight.w400,
  Color? color,
}) {
  final theme = Theme.of(context);
  return GoogleFonts.inter(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? theme.colorScheme.onBackground,
  );
}
