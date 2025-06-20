import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainOutlinedButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final double? height;
  final double? width;
  final Color? color;
  final double? elevation;
  final Color? titleColor;
  final Color? borderColor;
  final Widget? child;
  final double? radius;
  final BorderSide? side;
  final IconData? icon;
  final double iconSize;
  final Color? iconColor;
  final double spacing;

  const MainOutlinedButton({
    super.key,
    this.title,
    this.onTap,
    this.radius,
    this.height,
    this.side,
    this.elevation,
    this.width,
    this.child,
    this.color,
    this.titleColor,
    this.borderColor,
    this.icon,
    this.iconSize = 24.0,
    this.iconColor,
    this.spacing = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onTap == null;
    final textStyle = GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: isDisabled
          ? theme.disabledColor
          : titleColor ?? theme.textTheme.labelLarge?.color,
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          elevation: elevation ?? 0,
          backgroundColor: color ?? theme.colorScheme.background,
          side: side ??
              BorderSide(
                color: borderColor ?? theme.colorScheme.outline,
                width: 1,
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
        ),
        onPressed: onTap,
        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon,
                      size: iconSize, color: iconColor ?? textStyle.color),
                  SizedBox(width: spacing),
                ],
                Text(title ?? '', style: textStyle),
              ],
            ),
      ),
    );
  }
}
