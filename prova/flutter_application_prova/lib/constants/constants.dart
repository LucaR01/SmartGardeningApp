import 'package:flutter/material.dart';

//TODO: meglio con la classe perché così posso "referenziarla" in questo modo Constants.statusSuccess altrimenti scriverei soltanto statusSuccess e non si capirebbe
//TODO: da quale file lo sto recuperando

class Constants {
  static const String appVersion = 'v1.0.0';

  static const String appName = 'Smart Gardening';

  static const int statusSuccess = 200;

  static const bool defaultThemeIsDark = false;
  static const String defaultLanguage = 'en';
  static const ThemeMode defaultThemeMode = ThemeMode.light;
}