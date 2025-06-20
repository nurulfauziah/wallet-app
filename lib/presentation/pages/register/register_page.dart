import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/core/theme/app_theme.dart';
import 'package:wallet_app/core/widgets/main_dialog.dart';
import 'package:wallet_app/core/widgets/main_page_subtitle.dart';
import 'package:wallet_app/core/widgets/main_page_title.dart';
import 'package:wallet_app/l10n/languages.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_bloc.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_state.dart';
import 'package:wallet_app/presentation/pages/register/widgets/form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            MainDialog().dialogInfo(context,
                title: Languages.of(context).registrationSuccess,
                subtitle: Languages.of(context).registrationSuccessSubtitle,
                onTap: () {
              context.pushNamed(login);
            });
          } else if (state is RegisterError) {
            MainDialog().dialogInfo(context,
                isError: true, title: 'Failed', subtitle: state.message);
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                MainPageTitle(title: Languages.of(context).createYourAccount),
                SizedBox(height: 16),
                MainPageSubtitle(
                  subtitle: Languages.of(context).fillDetailsToRegister,
                ),
                const SizedBox(
                  height: 33.0,
                ),
                RegisterForm(),
                const SizedBox(
                  height: 24.0,
                ),
                Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(text: Languages.of(context).alreadyHaveAccount),
                    TextSpan(
                      text: ' ' + Languages.of(context).loginNow,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.linkColor,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.pushNamed(login),
                    ),
                  ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
