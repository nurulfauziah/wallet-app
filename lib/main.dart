import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/router/router.dart';
import 'package:wallet_app/core/theme/app_theme.dart';
import 'package:wallet_app/l10n/app_localizations.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_bloc.dart';
import 'package:wallet_app/presentation/cubit/currency/currency_bloc.dart';
import 'package:wallet_app/presentation/cubit/language/language_cubit.dart';
import 'package:wallet_app/presentation/cubit/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthCubit>()..checkAuthStatus(),
        ),
        BlocProvider(create: (_) => getIt<CurrencyCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<LanguageCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          ThemeMode themeMode = ThemeMode.light;
          if (state is ThemeChanged) {
            themeMode = state.mode;
          }
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, stateLanguage) {
              return MaterialApp.router(
                title: 'Wallet App',
                themeMode: themeMode,
                supportedLocales: const [
                  Locale('en', 'EN'),
                  Locale('id', 'ID'),
                ],
                localizationsDelegates: const [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode &&
                        supportedLocale.countryCode == locale?.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                locale: stateLanguage,
                theme: AppTheme.getLightTheme(),
                darkTheme: AppTheme.getDarkTheme(),
                routerConfig: router,
              );
            },
          );
        },
      ),
    );
  }
}
