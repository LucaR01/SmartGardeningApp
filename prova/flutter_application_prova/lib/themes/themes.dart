import 'package:flutter/material.dart';

//TODO: update values
//TODO: usare color_constants

class Themes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    primaryColor: Colors.green[500],
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.green[600], opacity: 0.8),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[850], //TODO: grey.shade900
    colorScheme: ColorScheme.dark(),
    brightness: Brightness.dark,
    primaryColor: Colors.grey[700],
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.green[900], opacity: 0.8),
  );
}