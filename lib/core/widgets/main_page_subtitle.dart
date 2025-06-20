import 'package:flutter/material.dart';
import 'package:wallet_app/core/helper/text_helper.dart';

class MainPageSubtitle extends StatelessWidget {
  final String subtitle;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const MainPageSubtitle({
    super.key,
    required this.subtitle,
    this.style,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: getTextStyle(
        context: context,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
