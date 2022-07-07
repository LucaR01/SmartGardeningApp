import 'package:flutter/material.dart';

class Languages {
  static final languages = [
    const Locale('en'),
    const Locale('it'),
  ];

  static String getFlag(String code) {
    switch(code) {
      case 'it':
        return 'U+1F1EE'; //TODO: add flag
      case 'en':
      default:
        return 'U+1F1EC'; //TODO: add flag
    }
  }
}