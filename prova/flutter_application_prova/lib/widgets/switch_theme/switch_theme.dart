import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_prova/provider/theme_provider.dart';

class SwitchThemeWidget extends StatelessWidget {
  const SwitchThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    //var val = UserPreferences.getIsDarkTheme() ?? themeProvider.isDarkMode; //TODO: non va

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      activeColor: Colors.green[600], //TODO: use themes
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}