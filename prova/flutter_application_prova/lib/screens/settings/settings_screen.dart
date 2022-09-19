import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';
import 'package:flutter_application_prova/provider/locale_provider.dart';
import 'package:flutter_application_prova/provider/theme_provider.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/switch_theme/switch_theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  static const bool DEFAULT_THEME_IS_DARK = false; //TODO: put in constants
  static const String DEFAULT_LANGUAGE = 'en'; //TODO: put in constants

  bool areNotificationsOn = false;

  late bool isDarkTheme;
  late String language;

  //TODO: remove
  onChangeNotifications(bool areNotifications) {
    setState(() {
      areNotificationsOn = areNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {

    // Prima cerco di recuperare il valore tra le preferenze dell'utente (quindi ciò che è stato salvato), se non trova niente, usiamo il tema e la lingua di sistema.
    isDarkTheme = UserPreferences.getIsDarkTheme() ?? Provider.of<ThemeProvider>(context).isDarkMode;
    language = UserPreferences.getLanguage() ?? Provider.of<LocaleProvider>(context).locale.languageCode;

    return Scaffold(
      appBar: const AppBarWidget(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.settings, //TODO: update icon
                  color: Theme.of(context).primaryColor, //TODO: green[500]
                ),
                SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context).settings,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1!.color),
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
                    color: Theme.of(context).primaryColor,
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
                  color: Theme.of(context).primaryColor, //TODO: green[600]
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).notifications, 
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText1!.color,
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
                  onPressed: () => _save(),
                  child: Text(
                    AppLocalizations.of(context).save,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2.1,
                      color: Theme.of(context).textTheme.bodyText1!.color,
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
                  onPressed: () => _reset(),
                  child: Text(
                    AppLocalizations.of(context).reset,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2.1,
                      color: Theme.of(context).textTheme.bodyText1!.color,
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
                    TextButton(
                      onPressed: () => _setLanguage(language: 'it'),
                      child: Text(AppLocalizations.of(context).italian),
                    ),
                    TextButton(
                      onPressed: () => _setLanguage(language: 'en'),
                      child: Text(AppLocalizations.of(context).english),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); //TODO: update
                    },
                    child: Text(AppLocalizations.of(context).close),
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
                color: Theme.of(context).primaryColor, //TODO: prima era grey[600]
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color, //TOOD: prima era grey
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
              color: Theme.of(context).primaryColor, //TODO: prima era grey[600]
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Theme.of(context).primaryColor, //TODO: green[600]
              trackColor: Colors.grey, //TODO:grey
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

  void _setLanguage({required String language}) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    this.language = language;
    provider.setLocale(Locale(this.language));
  }

  void _setTheme({required bool isDarkTheme}) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    provider.toggleTheme(isDarkTheme);
  }

  void _save() async {
    //TODO: volendo mostrare un messaggio con lo snackbar
    await UserPreferences.setTheme(isDarkTheme);
    await UserPreferences.setLanguage(language);

    print('SALVATAGGIO IMPOSTAZIONI');
    print('isDarkTheme: $isDarkTheme');
    print('language: $language');
  }

  void _reset() async {
    await UserPreferences.setTheme(DEFAULT_THEME_IS_DARK);
    await UserPreferences.setLanguage(DEFAULT_LANGUAGE);

    isDarkTheme = DEFAULT_THEME_IS_DARK;
    language = DEFAULT_LANGUAGE;

    _setLanguage(language: DEFAULT_LANGUAGE);
    _setTheme(isDarkTheme: DEFAULT_THEME_IS_DARK);

    print('RESET IMPOSTAZIONI');
    print('isDarkTheme: $isDarkTheme');
    print('language: $language');
  }
}
