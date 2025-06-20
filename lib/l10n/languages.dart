import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages)!;
  }

  String get email;
  String get password;
  String get login;
  String get dontHaveAccount;
  String get register;
  String get registerNow;
  String get name;
  String get wallet;
  String get hello;
  String get walletBalance;
  String get addBalance;
  String get efficientTopUp;
  String get createWallet;
  String get registrationSuccess;
  String get registrationSuccessSubtitle;
  String get loading;

  String get createYourAccount;
  String get fillDetailsToRegister;
  String get alreadyHaveAccount;
  String get loginNow;

  String get signInToYourAccount;

  String get enterEmailPassword;

  String get continueWithApple;

  String get continueWithFacebook;
  String get listWallet;
  String get noWalletFound;
  String get totalBalance;
  String get listTransactions;
  String get noTransactionFound;
  String get or;
  String get walletCreated;
  String get walletCreatedSuccessfully;
  String get deposit;
  String get continueText;
  String get initialBalance;
  String get withdrawal;
  String get withdrawalSubtitle;
  String get amount;
  String get depositSubtitle;
  String get settings;
  String get appSetting;
  String get customizeYourApp;
  String get themeMode;
  String get chooseThemeMode;
  String get language;
  String get changeYourLanguage;
  String get system;
  String get light;
  String get dark;
  String get english;
  String get bahasaIndonesia;
  String get logout;
  String get yourPersonalFinanceHub;
}
