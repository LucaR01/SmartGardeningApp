import 'package:flutter/material.dart';

/// It's used to have different colors based on the themeMode, either light or dark.
class Themes {
  static final ThemeData lightTheme = ThemeData(

    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    brightness: Brightness.light,
    primarySwatch: Colors.lightGreen,
    primaryColor: Colors.green[500],
    secondaryHeaderColor: Colors.green[300],
    primaryColorDark: Colors.green[900],
    textTheme: TextTheme(
      bodyText1: const TextStyle(
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        color: Colors.grey[400],
      ),
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
    accentIconTheme: const IconThemeData(color: Colors.green, opacity: 0.8), //TODO: questo è deprecato, da sostituire
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.green[500],
        onPrimary: Colors.green[700],
      ),
    ),

    textSelectionTheme: const TextSelectionThemeData( 
      selectionColor: Colors.white,
      selectionHandleColor: Colors.white70,
      cursorColor: Colors.lightGreenAccent,
    ),

    dividerColor: Colors.black87,

    bottomAppBarColor: Colors.green[600],
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[600],
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, 
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.green[600],
    ),

    backgroundColor: Colors.grey.shade300, //TODO: questo sembra non funzionare correttamente
  );

  static final ThemeData darkTheme = ThemeData(

    scaffoldBackgroundColor: Colors.grey[850], 
    colorScheme: const ColorScheme.dark(),
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
    primaryColor: Colors.grey[700], 
    primaryColorDark: Colors.white60,
    secondaryHeaderColor: Colors.grey[600],
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        color: Colors.white70,
      ),
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white70),
    iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
    accentIconTheme: IconThemeData(color: Colors.green[900], opacity: 0.8), //TODO: questo è deprecato, da sostituire
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green[900], 
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.green[900],
        onPrimary: Colors.green[500],
      ),
    ),

    textSelectionTheme: TextSelectionThemeData( 
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.black54,
      cursorColor: Colors.green[700],
    ),

    dividerColor: Colors.white70, 

    bottomAppBarColor: Colors.green[900],
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[900],
    ),
    appBarTheme: const AppBarTheme( 
      backgroundColor: Colors.transparent, 
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.green[900],
    ),

    backgroundColor: Colors.grey.shade900,
  );
}