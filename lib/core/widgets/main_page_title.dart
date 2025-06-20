import 'package:flutter/material.dart';
import 'package:wallet_app/core/helper/text_helper.dart';

class MainPageTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const MainPageTitle({
    super.key,
    required this.title,
    this.style,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getTextStyle(
        context: context,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
