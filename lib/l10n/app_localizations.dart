import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/languages.dart';
import 'package:wallet_app/l10n/languages_en.dart';
import 'package:wallet_app/l10n/languages_id.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.countryCode == "EN" && locale.languageCode == "en" ||
        locale.countryCode == "ID" && locale.languageCode == "id";
  }

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.toString()) {
      case 'en_EN':
        return LanguageEn();
      case 'id_ID':
        return LanguageId();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
