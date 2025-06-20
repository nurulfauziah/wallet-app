import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final EdgeInsetsGeometry? margin;

  const FormLabel({
    super.key,
    required this.text,
    this.style,
    this.margin = const EdgeInsets.only(bottom: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        text,
        style: style ??
            Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
      ),
    );
  }
}
