import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardening_app/themes/themes.dart';
import 'package:smart_gardening_app/provider/theme_provider.dart';

class SwitchThemeWidget extends StatelessWidget {
  const SwitchThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}