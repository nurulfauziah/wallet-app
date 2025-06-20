import 'package:flutter/material.dart';
import 'package:wallet_app/core/helper/text_helper.dart';
import 'package:wallet_app/l10n/languages.dart';

class DividerOr extends StatelessWidget {
  const DividerOr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color.fromARGB(255, 28, 26, 26).withOpacity(0.3),
            height: 1,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            Languages.of(context).or,
            style: getTextStyle(context: context, fontSize: 12),
          ),
        ),
        Expanded(
          child: Divider(
            color: const Color.fromARGB(255, 28, 26, 26).withOpacity(0.3),
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
