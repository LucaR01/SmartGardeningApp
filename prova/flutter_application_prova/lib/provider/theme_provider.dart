import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static bool? isDarkTheme = UserPreferences.getIsDarkTheme(); //TODO: remove, non me lo vede

  //ThemeMode themeMode = (isDarkTheme != null && isDarkTheme == false) ? ThemeMode.light : (isDarkTheme == null) ? ThemeMode.system : ThemeMode.dark; //TODO: prima era ThemeMode themeMode = ThemeMode.system;
  //ThemeMode themeMode = ThemeMode.system;
  ThemeMode themeMode = isDarkTheme == null ? ThemeMode.system : isDarkTheme == false ? ThemeMode.light : ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light; //TODO: prima era ThemeMode.dark : ThemeMode.light; avevo provato UserPreferences.getIsDarkTheme() ??
    notifyListeners(); 
  }
}