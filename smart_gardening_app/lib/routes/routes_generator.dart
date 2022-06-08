import 'package:flutter/material.dart';
import 'package:smart_gardening_app/screens/error_screen/error_screen.dart';
import 'package:smart_gardening_app/screens/my_plants/my_plants_screen.dart';
import 'package:smart_gardening_app/screens/settings/settings_screen.dart';
import 'package:smart_gardening_app/screens/tasks/tasks_screen.dart';

import '../main.dart';
import '../screens/diagnosis/diagnosis_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/scan/scan_screen.dart';
import '../screens/splash/splash_screen.dart';

//TODO: o chiamarli tutti screen o chiamarli tutti pages!

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/': 
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/splash':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/myplants':
        return MaterialPageRoute(builder: (_) => MyPlantsScreen());
      case '/tasks':
        return MaterialPageRoute(builder: (_) => TasksScreen());
      case '/diagnosis':
        return MaterialPageRoute(builder: (_) => DiagnosisScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/scan':
        return MaterialPageRoute(builder: (_) => ScanPage());
      default:
        return _errorRoute();
    }
  }

  //TODO: da aggiornare
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      //return FlashErrorScreen(); //TODO: uncomment
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
