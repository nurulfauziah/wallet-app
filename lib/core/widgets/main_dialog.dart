import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/helper/colors_helper.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/core/widgets/main_button.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_bloc.dart';

class MainDialog {
  Future<dynamic> dialogInfo(BuildContext context,
      {String? title,
      String? subtitle,
      String? image,
      bool isSuccess = false,
      bool isError = false,
      bool isInfo = false,
      String? titleButton,
      void Function()? onTap,
      bool barrierDismissible = true,
      bool isForceUpdate = false}) {
    return showDialog(
      barrierDismissible: barrierDismissible && !isForceUpdate,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => !isForceUpdate,
          child: AlertDialog(
            actionsPadding: const EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Message',
                  style: GoogleFonts.inter(
                    color: textBlackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isForceUpdate)
                  IconButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xff899197),
                    ),
                  ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isError == true
                    ? Icon(
                        Icons.info,
                        size: 40,
                        color: redColor,
                      )
                    : isInfo == true
                        ? const Icon(
                            Icons.info,
                            size: 40,
                            color: Colors.amber,
                          )
                        : SvgPicture.asset(
                            image ?? 'assets/svgs/ic_success.svg'),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: textBlackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                subtitle == null
                    ? const SizedBox()
                    : Text(
                        subtitle ?? '',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          color: const Color(0xFF899197),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                const SizedBox(
                  height: 32.0,
                ),
                MainButton(
                  title: titleButton ?? 'Ok',
                  onTap: onTap ??
                      () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
              value: context.read<AuthCubit>(),
              child: AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                      // TODO: implement logout logic
                      Navigator.pop(context);
                      context.goNamed(login);
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ));
  }
}
