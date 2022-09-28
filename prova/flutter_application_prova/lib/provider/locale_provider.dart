import 'package:flutter/material.dart';
import 'package:flutter_application_prova/constants/constants.dart';
import 'package:flutter_application_prova/l10n/languages.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale(UserPreferences.getLanguage() ?? Constants.englishLangCode);

  Locale get locale => _locale;
  
  void setLocale(Locale locale) {
    if(!Languages.languages.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale(Constants.defaultLanguage);
    notifyListeners();
  }
}