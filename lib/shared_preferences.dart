import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static const String APP_LOCALE = "app_localization";

  Future<Locale> setLocale(String languageCode) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(APP_LOCALE, languageCode);
    return _locale(languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(APP_LOCALE) ?? "en";
    return _locale(languageCode);
  }
}

Locale _locale(String languageCode) {
  Locale _tempLocale;
  switch (languageCode) {
    case "en":
      _tempLocale = Locale(languageCode, "US");
      break;
    case "hi":
      _tempLocale = Locale(languageCode, "IN");
      break;
    case "es":
      _tempLocale = Locale(languageCode, "AR");
      break;
    case "zh":
      _tempLocale = Locale(languageCode, "CN");
      break;
    default:
      _tempLocale = Locale(languageCode, "US");
  }
  return _tempLocale;
}
