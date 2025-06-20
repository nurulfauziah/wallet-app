import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/helper/preference_helper.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/core/theme/app_theme.dart';
import 'package:wallet_app/core/widgets/main_dialog.dart';
import 'package:wallet_app/core/widgets/main_outlined_button.dart';
import 'package:wallet_app/core/widgets/main_page_subtitle.dart';
import 'package:wallet_app/core/widgets/main_page_title.dart';
import 'package:wallet_app/l10n/languages.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_bloc.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_state.dart';
import 'package:wallet_app/presentation/pages/login/widgets/divider.dart';
import 'package:wallet_app/presentation/pages/login/widgets/form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            final preferencesHelper = getIt<PreferencesHelper>();
            preferencesHelper.setStringSharedPref('token', state.data.token);
            context.goNamed(wallet);
          } else if (state is LoginError) {
            MainDialog().dialogInfo(context,
                isError: true, title: 'Failed', subtitle: state.message);
          }
        },
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  MainPageTitle(
                      title: Languages.of(context).signInToYourAccount),
                  SizedBox(height: 16),
                  MainPageSubtitle(
                    subtitle: Languages.of(context).enterEmailPassword,
                  ),
                  const SizedBox(
                    height: 33.0,
                  ),
                  LoginForm(),
                  const SizedBox(
                    height: 24.0,
                  ),
                  DividerOr(),
                  const SizedBox(
                    height: 24.0,
                  ),
                  MainOutlinedButton(
                    title: Languages.of(context).continueWithApple,
                    onTap: () {},
                    icon: Icons.apple,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  MainOutlinedButton(
                    title: Languages.of(context).continueWithFacebook,
                    onTap: () {},
                    icon: Icons.facebook,
                    iconColor: Color.fromARGB(255, 46, 113, 214),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Center(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: Languages.of(context).dontHaveAccount),
                      TextSpan(
                        text: ' ' + Languages.of(context).registerNow,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.linkColor,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.pushNamed(register),
                      ),
                    ])),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
