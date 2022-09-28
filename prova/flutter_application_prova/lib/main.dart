import 'package:flutter/material.dart';
import 'package:flutter_application_prova/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';
import 'package:flutter_application_prova/provider/locale_provider.dart';
import 'package:flutter_application_prova/provider/theme_provider.dart';
import 'package:flutter_application_prova/routes/routes_generator.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_application_prova/themes/themes.dart';

//TODO: flutter run --release per lanciare in release mode
//TODO: oauth2_client iOS nel podfile scrivere: platform :ios, '11.0'
//TODO: add dartdoc?

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init(); 
  runApp(const App());
} 

//TODO: in initState() { super.initState(); NotificationsAPI.init(); listenNotifications(); } //TODO: quindi trasformare in un StatefulWidget; oppure remove

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  //TODO: uncomment or remove
  /*void listenNotifications() => NotificationsAPI.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => 
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ScanPage(payload: payload),
    ));*/

  @override
  Widget build(BuildContext context) => MultiProvider (
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
                create: (context) => LocaleProvider()
      ),
      ChangeNotifierProvider<ThemeProvider>(
                create: (context) => ThemeProvider()
      ),
    ],
    builder: (context, child) {
      final localeProvider = Provider.of<LocaleProvider>(context);
      final themeProvider = Provider.of<ThemeProvider>(context);

      return MaterialApp(
      debugShowCheckedModeBanner: false, // per rimuovere il debug tag
      title: Constants.appName,
      themeMode: themeProvider.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      locale: localeProvider.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      initialRoute: Constants.initialScreenRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
    }
  );
}