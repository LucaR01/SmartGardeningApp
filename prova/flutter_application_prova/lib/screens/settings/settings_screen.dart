import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';
import 'package:flutter_application_prova/constants/constants.dart';
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

  bool areNotificationsOn = false;

  bool? isDarkTheme; //= UserPreferences.getIsDarkTheme();
  String? language;

  bool? showOnBoarding = UserPreferences.getShowOnBoarding();

  @override
  void initState() {
    super.initState();

    isDarkTheme = UserPreferences.getIsDarkTheme() ?? Provider.of<ThemeProvider>(context).isDarkMode;
    language = UserPreferences.getLanguage() ?? Provider.of<LocaleProvider>(context).locale.languageCode;

    print('initState | isDarkTheme: $isDarkTheme - language: $language');
  }

  /*onChangeNotifications(bool areNotifications) {
    setState(() {
      areNotificationsOn = areNotifications;
    });
  }*/

  onShowOnBoarding(bool showOnBoarding) {
    setState(() {
      this.showOnBoarding = showOnBoarding;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const AppBarWidget(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.settings, 
                  color: Theme.of(context).primaryColor, 
                ),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context).settings,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            _buildOption(context, AppLocalizations.of(context).language), 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                const SizedBox(width: 20),
                Text(
                  AppLocalizations.of(context).theme,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500, 
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 30),
                const SwitchThemeWidget(), 
              ],
            ),
            /*SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Theme.of(context).primaryColor, 
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
            _buildSlideOption(AppLocalizations.of(context).notifications, areNotificationsOn, onChangeNotifications),*/
            const SizedBox(height: 40.0,),
            Row(
              children: [
                Icon(
                  Icons.integration_instructions_outlined,
                  color: Theme.of(context).primaryColor, 
                ),
                SizedBox(height: 10),
                Text(
                  'Intro screens', //TODO: localizations; Screens di benvenuto in italiano
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            _buildSlideOption('Activate Intro Pages', showOnBoarding ?? true, onShowOnBoarding), //TODO: localizations
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
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
                    padding: const EdgeInsets.symmetric(horizontal: 34.0),
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
                      child: Text(AppLocalizations.of(context).italian, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
                    ),
                    TextButton(
                      onPressed: () => _setLanguage(language: 'en'),
                      child: Text(AppLocalizations.of(context).english, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context).close, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
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
                fontWeight: FontWeight.w500, 
                color: Theme.of(context).primaryColor, 
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color, 
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSlideOption(String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500, 
              color: Theme.of(context).primaryColor, 
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.green[600], //TODO: use themes 
              trackColor: Colors.grey, //TODO: use themes
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
    print('_setLanguage: ${this.language}');
    provider.setLocale(Locale(this.language ?? Constants.defaultLanguage));
  }

  /*void _setTheme({required bool isDarkTheme}) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    this.isDarkTheme = isDarkTheme;
    print('_setTheme: ${this.isDarkTheme}');
  }*/

  void _save() async {
    isDarkTheme = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    language = Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;

    print('_save | language: $language');

    print('_save: theme: $isDarkTheme e lang: $language');

    dynamic hasSavedTheme = await UserPreferences.setTheme(isDarkTheme!);
    dynamic hasSavedLanguage = await UserPreferences.setLanguage(language!);
    dynamic hasSavedShowOnBoarding = await UserPreferences.setShowOnBoarding(showOnBoarding ?? true);

    print('hasSavedTheme: $hasSavedTheme');
    print('hasSavedLanguage: $hasSavedLanguage');
    print('hasSavedShowOnBoarding: $hasSavedShowOnBoarding');

    //TODO: localizations
    (hasSavedTheme && hasSavedLanguage && hasSavedShowOnBoarding) == true ? SnackBarMessageWidget.snackBarMessage(context: context, title: 'Saved', msg: 'Data saved successfully!', errorCode: ErrorCodes.success) : SnackBarMessageWidget.snackBarMessage(context: context, title: 'Failed to save', msg: 'Data not saved!', errorCode: ErrorCodes.error);

    print('SALVATAGGIO IMPOSTAZIONI');
    print('isDarkTheme: ${isDarkTheme ?? true}');
    print('showOnBoarding: $showOnBoarding');
    print('language: $language');
  }

  void _reset() async {
    dynamic hasResetTheme = await UserPreferences.setTheme(Constants.defaultThemeIsDark);
    dynamic hasResetLanguage = await UserPreferences.setLanguage(Constants.defaultLanguage);
    dynamic hasResetShowOnBoarding =await UserPreferences.setShowOnBoarding(Constants.defaultShowOnBoarding);

    this.isDarkTheme = Constants.defaultThemeIsDark;
    this.language = Constants.defaultLanguage; 

    Provider.of<ThemeProvider>(context, listen: false).setThemeMode(Constants.defaultThemeMode);
    Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale(Constants.defaultLanguage));
    onShowOnBoarding(Constants.defaultShowOnBoarding);


    print('hasSavedTheme: $hasResetTheme');
    print('hasSavedLanguage: $hasResetLanguage');
    print('hasSavedShowOnBoarding: $hasResetShowOnBoarding');

    //TODO: localizations
    hasResetTheme && hasResetLanguage && hasResetShowOnBoarding == true ? SnackBarMessageWidget.snackBarMessage(context: context, title: 'Reset', msg: 'Data reset successfully!', errorCode: ErrorCodes.success) : SnackBarMessageWidget.snackBarMessage(context: context, title: 'Failed to reset', msg: 'Data not reset!', errorCode: ErrorCodes.error);

    print('RESET IMPOSTAZIONI');
    print('isDarkTheme: $isDarkTheme');
    print('showOnBoarding: $showOnBoarding');
    print('language: $language');
  }
}
