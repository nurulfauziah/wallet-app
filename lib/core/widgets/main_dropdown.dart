// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_app/core/helper/colors_helper.dart';
import 'package:wallet_app/core/helper/text_helper.dart';

class MainDropdown extends StatelessWidget {
  final double? width;
  final String? title;
  final Widget? titleWidget;
  final dynamic selectedValue;
  final Color? titleColor;
  final Color? dropdownColor;
  final Color? fillColor;
  final Color? borderColor;
  final double? titleFontSize;
  final Color? iconColor;
  final BoxDecoration? boxDecoration;
  final EdgeInsetsGeometry? buttonPadding;
  final Function(dynamic)? onChanged;
  final List<DropdownMenuItem<Object>>? items;

  /// New: optional form label (above dropdown)
  final String? formLabel;
  final bool showFormLabel;

  const MainDropdown({
    Key? key,
    this.width,
    this.titleWidget,
    this.onChanged,
    this.boxDecoration,
    this.titleFontSize,
    this.buttonPadding,
    this.title,
    this.titleColor,
    this.dropdownColor,
    this.borderColor,
    this.fillColor,
    required this.items,
    this.iconColor,
    this.selectedValue,
    this.formLabel,
    this.showFormLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showFormLabel && formLabel != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              formLabel!,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1C1C1E),
              ),
            ),
          ),
        Container(
          width: width ?? MediaQuery.of(context).size.width,
          padding: EdgeInsets.zero,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: titleWidget ??
                  Text(
                    title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: const Color(0xff899197),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              items: items,
              value: selectedValue,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: baseColor,
                  ),
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: iconColor ?? Colors.grey,
                  ),
                ),
                iconSize: 24,
              ),
              buttonStyleData: ButtonStyleData(
                height: 55,
                decoration: boxDecoration ??
                    BoxDecoration(
                      color: fillColor ?? Colors.white,
                      border: Border.all(color: borderColor ?? formBorderColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                elevation: 0,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: dropdownColor ?? Colors.white,
                ),
                elevation: 2,
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
                offset: const Offset(0, 0),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
