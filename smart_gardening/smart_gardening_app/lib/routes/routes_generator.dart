import 'package:flutter/material.dart';
import 'package:smart_gardening_app/models/plant/plant.dart';
import 'package:smart_gardening_app/screens/diagnosis/diagnosis_screen.dart';
import 'package:smart_gardening_app/screens/home/home_screen.dart';
import 'package:smart_gardening_app/screens/my_plants/my_plants_screen.dart';
import 'package:smart_gardening_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:smart_gardening_app/screens/my_plants/plant_details.dart';
import 'package:smart_gardening_app/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:smart_gardening_app/screens/scan/scan_screen.dart';
import 'package:smart_gardening_app/screens/scan_result_screen/scan_result_screen.dart';
import 'package:smart_gardening_app/screens/sensors/sensors_screen.dart';
import 'package:smart_gardening_app/screens/settings/settings_screen.dart';
import 'package:smart_gardening_app/screens/splash/splash_screen.dart';
import 'package:smart_gardening_app/screens/terms_and_conditions/terms_and_conditions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  /// It shows an error page if the route is wrong.
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(_).error),
        ),
        body: Center(
          child: Text(AppLocalizations.of(_).error.toUpperCase()), 
        ),
      );
    });
  }
}
