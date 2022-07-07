import 'package:flutter/material.dart';
import 'package:smart_gardening_app/l10n/languages.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); //TODO: 

  Locale get locale => _locale;
  
  void setLocale(Locale locale) {
    if(!Languages.languages.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en'); //TODO: 
    notifyListeners();
  }
}