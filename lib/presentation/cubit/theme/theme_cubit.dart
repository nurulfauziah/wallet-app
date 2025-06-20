import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
part 'theme_state.dart';

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  ThemeMode _currentMode = ThemeMode.system;

  ThemeCubit() : super(ThemeInitial());

  ThemeMode get currentMode => _currentMode;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme_mode') ?? 'system';

    switch (themeString) {
      case 'light':
        _currentMode = ThemeMode.light;
        break;
      case 'dark':
        _currentMode = ThemeMode.dark;
        break;
      default:
        _currentMode = ThemeMode.system;
    }

    emit(ThemeChanged(_currentMode));
  }

  Future<void> changeTheme(ThemeMode mode) async {
    _currentMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', _themeModeToString(mode));
    emit(ThemeChanged(_currentMode));
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }
}
