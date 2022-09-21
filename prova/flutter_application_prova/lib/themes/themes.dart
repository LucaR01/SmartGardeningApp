import 'package:flutter/material.dart';

//TODO: update values
//TODO: usare color_constants

class Themes {
  static final ThemeData lightTheme = ThemeData(

    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    brightness: Brightness.light,
    primarySwatch: Colors.lightGreen,
    primaryColor: Colors.green[500],
    secondaryHeaderColor: Colors.green[300], //TODO: non so cosa sia questo nè a cosa serva
    primaryColorDark: Colors.green[900],
    textTheme: TextTheme(
      bodyText1: const TextStyle(
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        color: Colors.grey[400], //TODO: grey[300]?
      ),
    ),
    primaryIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.black/*TODO: Colors.green[600]*/, opacity: 0.8),
    accentIconTheme: IconThemeData(color: Colors.green, opacity: 0.8), //TODO: fix, usare qualcos'altro.
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green, //TODO: verificare se va bene
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.green[500],
        onPrimary: Colors.green[700],
      ),
    ),

    textSelectionTheme: const TextSelectionThemeData( //TODO: vedere se i colori vanno bene
      selectionColor: Colors.white,
      selectionHandleColor: Colors.white70,
      cursorColor: Colors.lightGreenAccent,
    ),

    dividerColor: Colors.black87, //TODO: verificare oppure white70

    bottomAppBarColor: Colors.green[600],
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[600],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,  //TODO: cambiare?
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.green[600],
    ),
  );

  static final ThemeData darkTheme = ThemeData(

    scaffoldBackgroundColor: Colors.grey[850], //TODO: grey.shade900
    colorScheme: ColorScheme.dark(),
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
    primaryColor: Colors.grey[700], //TODO: grey[600]?
    primaryColorDark: Colors.white60,
    secondaryHeaderColor: Colors.grey[600], //TODO: non so cosa sia questo nè a cosa serva
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        color: Colors.white70,
      ),
    ),
    primaryIconTheme: IconThemeData(color: Colors.white70),
    iconTheme: IconThemeData(color: Colors.white/*TODO: Colors.green[900]*/, opacity: 0.8),
    accentIconTheme: IconThemeData(color: Colors.green[900], opacity: 0.8),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green[900], //TODO: verificare se va bene
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.green[900],
        onPrimary: Colors.green[500],
      ),
    ),

    textSelectionTheme: TextSelectionThemeData( //TODO: vedere se i colori vanno bene
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.black54,
      cursorColor: Colors.green[700],
    ),

    dividerColor: Colors.white70, //TODO: da verificare

    bottomAppBarColor: Colors.green[900],
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[900],
    ),
    appBarTheme: AppBarTheme( 
      backgroundColor: Colors.transparent, //TODO: cambiare?
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.green[900],
    ),
  );
}