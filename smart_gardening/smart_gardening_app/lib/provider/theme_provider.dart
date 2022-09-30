import 'package:flutter/material.dart';
import 'package:smart_gardening_app/models/shared_preferences/user_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static bool? isDarkTheme = UserPreferences.getIsDarkTheme();
  ThemeMode themeMode = isDarkTheme == null ? ThemeMode.system : isDarkTheme == false ? ThemeMode.light : ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  /// Set a new [theme] and update the listeners with [notifyListeners], which
  /// updates the UI, like the SwitchThemeWidget and the settings in the SettingsScreen.
  void setThemeMode(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }

  /// It swaps the current [themeMode] and update the listeners with [notifyListeners], which
  /// updates the UI, like the SwitchThemeWidget and the settings in the SettingsScreen.
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); 
  }
}