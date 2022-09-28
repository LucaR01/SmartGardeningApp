import 'package:flutter/material.dart';
import 'package:flutter_application_prova/constants/constants.dart';
import 'package:flutter_application_prova/l10n/languages.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale(UserPreferences.getLanguage() ?? Constants.englishLangCode);

  Locale get locale => _locale;
  
  /// It sets a new [locale] if it is present in the [Languages.languages] list.
  /// Then it updates the listeners with [notifyListeners] which
  /// updates the UI, like the LanguagePickerWidget and the settings in the SettingsScreen.
  void setLocale(Locale locale) {
    if(!Languages.languages.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  /// It updates the [_locale] to the [Constants.defaultLanguage] and [notifyListeners] which
  /// updates the UI, like the LanguagePickerWidget and the settings in the SettingsScreen.
  void clearLocale() {
    _locale = const Locale(Constants.defaultLanguage);
    notifyListeners();
  }
}