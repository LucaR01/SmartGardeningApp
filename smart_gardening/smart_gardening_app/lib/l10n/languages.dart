import 'package:flutter/material.dart';
import 'package:smart_gardening_app/constants/constants.dart';

class Languages {
  static final languages = [
    const Locale(Constants.englishLangCode),
    const Locale(Constants.italianLangCode),
  ];

  static String getFlag(String code) {
    switch(code) {
      case Constants.italianLangCode:
        return '🇮🇹'; //"U+1F1EE U+1F1F9"; //'U+1F1EE'; 
      case Constants.englishLangCode:
      default:
        return '🇬🇧'; //'U+1F1EC U+1F1E7'; //'U+1F1EC';
    }
  }
}