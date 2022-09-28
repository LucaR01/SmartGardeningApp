import 'package:flutter/material.dart';

/// It contains all the constants (both string and non-strings).
/// There are only strings that don't need to be translated with internationalization.
class Constants {

  static const String appVersion = 'v1.0.0';

  static const String appName = 'Smart Gardening';

  static const int statusSuccess = 200;
  static const int statusFAIL = 0;

  static const bool defaultThemeIsDark = false;
  static const String defaultLanguage = 'en';
  static const ThemeMode defaultThemeMode = ThemeMode.light;
  static const bool defaultShowOnBoarding = true;

  static const String databaseName = 'plants';
  static const String databaseExtension = '.db';

  static const String englishLangCode = 'en';
  static const String italianLangCode = 'it';

  static const String iconHomeAssetsPath = 'assets/icons/home/';

  static const String initialScreenRoute = '/splash';
  
}