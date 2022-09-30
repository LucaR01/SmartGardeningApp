import 'package:flutter/material.dart';

/// There are all the colors that don't need to change based on the app's theme (Light or Dark Themes).
class ColorConstants {

  static Color? snackBarSuccessMessage = Colors.green[700];
  static Color? snackBarErrorMessage = Colors.red[700];

  static Color? onBoardingGlobalBackgroundColor = Colors.orange[500];
  static Color? onBoardingDoneTextColor = Colors.green[900];
  
  static Color? settingsSlideOptionActiveColor = Colors.green[600];
  static const Color settingsSlideOptionTrackColor = Colors.grey;

  static const Color navigationDrawerMenuItemTextColor = Colors.white;
  static Color? navigationDrawerMenuItemHoverColor = Colors.white70;
  static const Color navigationDrawerAppNameTextColor = Colors.white;
  static Color? navigationDrawerAppVersionTextColor = Colors.grey[300];

  static Color? switchThemeActiveColor = Colors.green[600];
}