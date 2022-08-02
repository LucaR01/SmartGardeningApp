import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardening_app/models/shared_preferences/user_preferences.dart';
import 'package:smart_gardening_app/widgets/app_bar/app_bar.dart';
import 'package:smart_gardening_app/widgets/switch_theme/switch_theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const bool DEFAULT_THEME = false; //TODO: put in constants
  static const String DEFAULT_LANGUAGE = 'en'; //TODO: put in constants

  bool isDarkTheme = false; //TODO: recuperare dal ThemeProvider
  bool areNotificationsOn = false;
  String language = '';

  @override
  void initState() {
    super.initState();

    isDarkTheme = UserPreferences.getIsDarkTheme() ?? DEFAULT_THEME; // ?? vuol dire che se è null, mette il valore false.
    language = UserPreferences.getLanguage() ?? DEFAULT_LANGUAGE; //TODO: per la lingua mi serve un Locale, non una stringa, quindi faccio Locale(language);
  }

  //TODO: remove
  onChangeTheme(bool isDark) {
    setState(() {
      isDarkTheme = isDark;
    });
  }

  //TODO: remove
  onChangeNotifications(bool areNotifications) {
    setState(() {
      areNotificationsOn = areNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.settings, //TODO: update icon
                  color: Colors.green[500], //TODO: use color constants
                ),
                SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context).settings,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            _buildOption(context, AppLocalizations.of(context).language), //TODO: use string constants
            //_buildSlideOption('Tema', isDarkTheme, onChangeTheme), //TODO: remove
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                const SizedBox(width: 20),
                Text(
                  AppLocalizations.of(context).theme,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500, //TODO:
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 30),
                const SwitchThemeWidget(),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.green[600], //TODO: use color constants
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).notifications, 
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            _buildSlideOption(
                AppLocalizations.of(context).notifications, areNotificationsOn, onChangeNotifications),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    await UserPreferences.setTheme(isDarkTheme);
                    await UserPreferences.setLanguage(language);

                    print('SALVATAGGIO IMPOSTAZIONI');
                    print('theme: $isDarkTheme');
                    print('language: $language');
                  },
                  child: Text(
                    AppLocalizations.of(context).save,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2.1,
                      color: Colors.black, //TODO: use color constants
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    await UserPreferences.setTheme(DEFAULT_THEME);
                    await UserPreferences.setLanguage(DEFAULT_LANGUAGE);

                    isDarkTheme = DEFAULT_THEME;
                    language = DEFAULT_LANGUAGE;

                    print('RESET IMPOSTAZIONI');
                    print('theme: $isDarkTheme');
                    print('language: $language');
                  },
                  child: Text(
                    AppLocalizations.of(context).reset,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2.1,
                      color: Colors.black, //TODO: use color constants
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Italiano'), //TODO: usare localization
                    Text('Inglese'), //TODO: usare localization
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); //TODO: update
                    },
                    child: Text('Close'), //TODO: update
                  ),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500, //TODO:
                color: Colors.grey[600], //TODO: use color constants
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey, //TODO: use color constants
            ),
          ],
        ),
      ),
    );
  }

  //TODO: rename in _buildSlidingOption?
  Padding _buildSlideOption(String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500, //TODO:
              color: Colors.grey[600], //TODO: use color constants
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.green[600], //TODO: use color constants
              trackColor: Colors.grey, //TODO: use color constants
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
