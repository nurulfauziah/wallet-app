// presentation/bloc/language_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

const String prefSelectedLanguageCode = "key_language";

@injectable
class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en', 'EN')) {
    _loadLocale();
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString(prefSelectedLanguageCode) ?? "en-EN";
    emit(_parseLocale(lang));
  }

  void changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefSelectedLanguageCode, languageCode);
    emit(_parseLocale(languageCode));
  }

  Locale _parseLocale(String code) {
    final parts = code.split('-');
    return Locale(parts[0], parts[1]);
  }
}
