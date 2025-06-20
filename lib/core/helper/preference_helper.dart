import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class PreferencesHelper {
  final SharedPreferences sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> isSharedPref(String key) async {
    return sharedPreferences.getBool(key) ?? false;
  }

  void setSharedPref(String key, bool value) {
    sharedPreferences.setBool(key, value);
  }

  Future<String> getStringSharedPref(String key) async {
    return sharedPreferences.getString(key) ?? '';
  }

  void setStringSharedPref(String key, String data) {
    sharedPreferences.setString(key, data);
  }

  void removeStringSharedPref(String key) {
    sharedPreferences.remove(key);
  }

  String get getToken {
    return sharedPreferences.getString('token') ?? '';
  }
}
