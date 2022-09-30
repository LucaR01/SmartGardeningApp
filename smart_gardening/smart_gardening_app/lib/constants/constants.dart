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

  static const String sensorAPIGrantTypePassword = 'password';
  static const String sensorAPIGrantTypeRefreshToken = 'refresh_token';

  static const String sensorAPIScope = 'read_homecoach';

  static const String sensorAPIMethod = 'POST';
  static const String sensorAPICharset = 'UTF-8';

  static const String sensorAPIAcceptJson = 'application/json';
  static const String sensorAPIContentType = 'application/x-www-form-urlencoded';

  static const String sensorAPITokenUrl = 'https://api.netatmo.com/oauth2/token';
  static const String sensorAPIApiUrl = 'https://api.netatmo.com/api';
  static const String sensorAPIGetHomeCoachsDataUrl = '/gethomecoachsdata?device_id=';
  
}