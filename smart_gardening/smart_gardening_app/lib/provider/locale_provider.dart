import 'package:flutter/material.dart';
import 'package:smart_gardening_app/constants/constants.dart';
import 'package:smart_gardening_app/l10n/languages.dart';
import 'package:smart_gardening_app/models/shared_preferences/user_preferences.dart';

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