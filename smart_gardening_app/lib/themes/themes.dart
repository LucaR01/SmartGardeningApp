import 'package:flutter/material.dart';

//TODO: update values
//TODO: usare color_constants

/*class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); 
  }
}*/

class Themes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    brightness: Brightness.light,
    primarySwatch: Colors.orange,
    primaryColor: Colors.orange[500],
    /*primaryColorBrightness: Brightness.light,
    accentColor: Colors.purple[500],
    accentColorBrightness: Brightness.light*/
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[850], //TODO: grey.shade900
    colorScheme: ColorScheme.dark(),
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    /*primaryColorBrightness: Brightness.dark,
    accentColor: Colors.blue[500],
    accentColorBrightness: Brightness.dark,*/
  );
}