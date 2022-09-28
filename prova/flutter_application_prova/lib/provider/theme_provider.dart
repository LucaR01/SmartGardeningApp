import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static bool? isDarkTheme = UserPreferences.getIsDarkTheme();
  ThemeMode themeMode = isDarkTheme == null ? ThemeMode.system : isDarkTheme == false ? ThemeMode.light : ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); 
  }
}