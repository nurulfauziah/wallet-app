import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/core/widgets/main_dialog.dart';
import 'package:wallet_app/core/widgets/main_outlined_button.dart';
import 'package:wallet_app/core/widgets/main_dropdown.dart';
import 'package:wallet_app/presentation/cubit/language/language_cubit.dart';
import 'package:wallet_app/presentation/cubit/theme/theme_cubit.dart';
import 'package:wallet_app/presentation/pages/settings/widgets/build_setting_card.dart';
import 'package:wallet_app/l10n/languages.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).settings),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Languages.of(context).appSetting,
                style: textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                Languages.of(context).customizeYourApp,
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              BuildSettingCard(
                  title: Languages.of(context).themeMode,
                  subtitle: Languages.of(context).chooseThemeMode,
                  trailing: BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      ThemeMode mode = ThemeMode.system;
                      if (state is ThemeChanged) {
                        mode = state.mode;
                      }

                      return MainDropdown(
                        width: 130,
                        selectedValue: mode,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<ThemeCubit>().changeTheme(value);
                          }
                        },
                        items: [
                          DropdownMenuItem(
                              value: ThemeMode.system,
                              child: Text(Languages.of(context).system)),
                          DropdownMenuItem(
                              value: ThemeMode.light,
                              child: Text(Languages.of(context).light)),
                          DropdownMenuItem(
                              value: ThemeMode.dark,
                              child: Text(Languages.of(context).dark)),
                        ],
                      );
                    },
                  )),
              const SizedBox(height: 16),
              BuildSettingCard(
                  title: Languages.of(context).language,
                  subtitle: Languages.of(context).changeYourLanguage,
                  trailing: BlocBuilder<LanguageCubit, Locale>(
                    builder: (context, state) {
                      final languageCode = state.languageCode;
                      return MainDropdown(
                        width: 130,
                        selectedValue: languageCode,
                        onChanged: (value) {
                          if (value != null) {
                            if (value == 'en') {
                              context
                                  .read<LanguageCubit>()
                                  .changeLanguage('en-EN');
                            } else if (value == 'id') {
                              context
                                  .read<LanguageCubit>()
                                  .changeLanguage('id-ID');
                            }
                          }
                        },
                        items: [
                          DropdownMenuItem(
                              value: 'en',
                              child: Text(Languages.of(context).english)),
                          DropdownMenuItem(
                              value: 'id',
                              child:
                                  Text(Languages.of(context).bahasaIndonesia)),
                        ],
                      );
                    },
                  )),
              const Spacer(),
              Center(
                child: MainOutlinedButton(
                  onTap: () => MainDialog().showLogoutDialog(context),
                  borderColor: colorScheme.error,
                  titleColor: colorScheme.error,
                  title: Languages.of(context).logout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
