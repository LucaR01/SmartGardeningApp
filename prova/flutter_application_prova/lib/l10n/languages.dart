import 'package:flutter/material.dart';

class Languages {
  static final languages = [
    const Locale('en'),
    const Locale('it'),
  ];

  static String getFlag(String code) {
    switch(code) {
      case 'it':
        return '🇮🇹'; //"U+1F1EE U+1F1F9"; //'U+1F1EE'; 
      case 'en':
      default:
        return '🇬🇧'; //'U+1F1EC U+1F1E7'; //'U+1F1EC';
    }
  }
}