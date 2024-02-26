import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale _locale;
  AppLocalization(this._locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  late Map<String, String> _localizedValues;

  Future loadLanguage() async {
    String jsonStringValues = await rootBundle.loadString(
      "assets/lang/${_locale.languageCode}.json",
    );
    Map<String, dynamic> mappedValues = jsonDecode(jsonStringValues);
    _localizedValues =
        mappedValues.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();
}

// delegate for AppLocalization
class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

// It will check if the user's locale is supported by our App or not
  @override
  bool isSupported(Locale locale) {
    return ["en", "hi", "es", "zh"].contains(locale.languageCode);
  }

// It will load the equivalent json file requested by the user
  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.loadLanguage();
    return appLocalization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
