import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_prova/api/notifications/notifications_api.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';
import 'package:flutter_application_prova/provider/locale_provider.dart';
import 'package:flutter_application_prova/provider/theme_provider.dart';
import 'package:flutter_application_prova/routes/routes_generator.dart';

//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_application_prova/themes/themes.dart';

import 'screens/home/home_screen.dart'; //TODO: package:smart_gardening_app/home/home_screen.dart
import 'screens/splash/splash_screen.dart'; //TODO: package:smart_gardening_app/splash/splash_screen.dart

//TODO: flutter run --release per lanciare in release mode
//TODO: card class

//TODO: WidgetsFlutterBinding.ensureInitialized();

//TODO: Localization per iOS

//TODO: Future<void>
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init(); //TODO: metterlo in App?
  runApp(const App()); //TODO: const MaterialApp();
} 

//TODO: in initState() { super.initState(); NotificationsAPI.init(); listenNotifications(); } //TODO: quindi trasformare in un StatefulWidget

//TODO: spostare App class in un altro file a parte?
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  //TODO: uncomment
  /*void listenNotifications() => NotificationsAPI.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => 
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ScanPage(payload: payload),
    ));*/

  // This widget is the root of your application.
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
      title: 'Smart Gardening App',
      themeMode: themeProvider.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      locale: localeProvider.locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [ //TODO: remove
        Locale('en', ''),
        Locale('it', ''),
      ],

      // Al posto di quello sopra, volendo posso mettere semplicemente queste due:
      //localizationsDelegates: AppLocalizations.localizationsDelegates,
      //supportedLocales: AppLocalizations.supportedLocales,

      /*theme: ThemeData( //TODO: remove
        primarySwatch: Colors.green,
      ),*/
      initialRoute: '/splash',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
    }
  );
}