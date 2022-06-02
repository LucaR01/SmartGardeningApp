import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    //TODO: aggiungere le altre routes
    switch (settings.name) {
      case '/': //TODO: update
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/splash':
        return MaterialPageRoute(builder: (_) => Splash());
      /*case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());*/
      default:
        return _errorRoute();
    }
  }

  //TODO: da aggiornare
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
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
