import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/screens/diagnosis/diagnosis_screen.dart';
import 'package:flutter_application_prova/screens/home/home_screen.dart';
import 'package:flutter_application_prova/screens/my_plants/my_plants_screen.dart';
import 'package:flutter_application_prova/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter_application_prova/screens/plant_details/plant_details.dart';
import 'package:flutter_application_prova/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:flutter_application_prova/screens/scan/scan_screen.dart';
import 'package:flutter_application_prova/screens/scan_result_screen/scan_result_screen.dart';
import 'package:flutter_application_prova/screens/sensors/sensors_screen.dart';
import 'package:flutter_application_prova/screens/settings/settings_screen.dart';
import 'package:flutter_application_prova/screens/splash/splash_screen.dart';
import 'package:flutter_application_prova/screens/terms_and_conditions/terms_and_conditions.dart';

//TODO: o chiamarli tutti screen o chiamarli tutti pages!

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/': 
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/splash': 
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/myplants':
        return MaterialPageRoute(builder: (_) => const MyPlantsScreen());
      case '/myplants/details':
        if(args is Plant) {
          return MaterialPageRoute(
            builder: (_) => PlantDetails(plant: args)
          );
        }
        return _errorRoute();
      case '/diagnosis':
        return MaterialPageRoute(builder: (_) => const DiagnosisScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/scan':
        return MaterialPageRoute(builder: (_) => const ScanPage());
      case '/scan/result':
        if(args is Plant) {
          return MaterialPageRoute(
            builder: (_) => ScanResultScreen(plant: args)
          );
        }
        return _errorRoute();
      case '/sensors':
        return MaterialPageRoute(builder: (_) => const SensorPage());
      case '/privacy/policy':
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
      case '/terms/conditions':
        return MaterialPageRoute(builder: (_) => const TermsAndConditionsPage());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'), //TODO: localizations
        ),
        body: Center(
          child: Text('ERROR'), //TODO: localizations .toUpper()
        ),
      );
    });
  }
}
