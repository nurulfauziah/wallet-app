import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_app/core/helper/colors_helper.dart';
import 'package:wallet_app/core/widgets/form_label.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.maxLength,
    this.readOnly,
    this.enabled,
    this.onTap,
    this.minLines = 1,
    this.obscureText,
    this.maxLines,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.prefixIcon,
    this.onComplete,
    this.onChanged,
    this.border,
    this.hintStyle,
    this.keyboardType,
    this.errorTextFromServer,
    this.contentPaddingVertical,
    this.contentPaddingHorizontal,
    this.fillColor,
    this.isDense,
    this.borderRadius,
    this.onFieldSubmitted,
    this.autoValidateMode,
  });

  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool? readOnly;
  final bool? enabled;
  final bool? isDense;
  final bool? obscureText;
  final int? minLines;
  final int? maxLines;
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onComplete;
  final void Function(String)? onChanged;
  final InputBorder? border;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final double? contentPaddingVertical;
  final double? contentPaddingHorizontal;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final void Function(String)? onFieldSubmitted;
  final AutovalidateMode? autoValidateMode;
  final Widget? prefixIcon;
  final String? errorTextFromServer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          FormLabel(text: labelText!),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          obscureText: obscureText ?? false,
          enabled: enabled,
          readOnly: readOnly ?? false,
          onTap: onTap,
          inputFormatters: inputFormatters,
          onEditingComplete: onComplete,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
          maxLength: maxLength,
          style: const TextStyle(color: Color(0xFF7D8998)),
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorTextFromServer,
            filled: true,
            fillColor: fillColor ?? Colors.white,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: contentPaddingHorizontal ?? 14,
              vertical: contentPaddingVertical ?? 14,
            ),
            isDense: isDense ?? true,
            border: border ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: formBorderColor),
                  borderRadius: borderRadius ?? BorderRadius.circular(16),
                ),
            enabledBorder: border ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: formBorderColor),
                  borderRadius: borderRadius ?? BorderRadius.circular(16),
                ),
            focusedBorder: border ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: formBorderColor),
                  borderRadius: borderRadius ?? BorderRadius.circular(16),
                ),
            hintStyle: hintStyle ??
                GoogleFonts.inter(
                  color: const Color(0xff899197),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
          validator: validator ??
              (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
        ),
      ],
    );
  }
}
