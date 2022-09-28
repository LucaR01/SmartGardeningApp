import 'package:flutter/material.dart';
import 'package:flutter_application_prova/constants/colors_constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_prova/provider/theme_provider.dart';

class SwitchThemeWidget extends StatelessWidget {
  const SwitchThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      activeColor: ColorConstants.switchThemeActiveColor,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}