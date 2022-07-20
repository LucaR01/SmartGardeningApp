import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences; // prima era static SharedPreferences _preferences;

  static const _keyIsDarkTheme = 'isDarkTheme';
  static const _keyLanguage = 'language';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setTheme(bool isDark) async => await _preferences.setBool(_keyIsDarkTheme, isDark);

  static Future setLanguage(String language) async => await _preferences.setString(_keyLanguage, language);

  static bool? getIsDarkTheme() => _preferences.getBool(_keyIsDarkTheme); // prima era bool e _preferences.getBool(_keyIsDarkTheme)!;

  static String? getLanguage() => _preferences.getString(_keyLanguage); // prima era return type String e _preferences.getString(_keyLanguage)!;
}