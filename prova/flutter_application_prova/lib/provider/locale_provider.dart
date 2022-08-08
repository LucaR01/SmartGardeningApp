import 'package:flutter/material.dart';
import 'package:flutter_application_prova/l10n/languages.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  
  void setLocale(Locale locale) {
    if(!Languages.languages.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }
}