import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/models/plant/plant_disease.dart';
import 'package:flutter_application_prova/screens/diagnosis/diagnosis_screen.dart';
import 'package:flutter_application_prova/screens/diagnosis_scan_result/diagnosis_scan_result_screen.dart';
import 'package:flutter_application_prova/screens/home/home_screen.dart';
import 'package:flutter_application_prova/screens/my_plants/my_plants_screen.dart';
import 'package:flutter_application_prova/screens/plant_details/plant_details.dart';
import 'package:flutter_application_prova/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:flutter_application_prova/screens/scan/scan_screen.dart';
import 'package:flutter_application_prova/screens/scan_result_screen/scan_result_screen.dart';
import 'package:flutter_application_prova/screens/sensors/sensors_screen.dart';
import 'package:flutter_application_prova/screens/settings/settings_screen.dart';
import 'package:flutter_application_prova/screens/splash/splash_screen.dart';
import 'package:flutter_application_prova/screens/tasks/tasks_screen.dart';
import 'package:flutter_application_prova/screens/terms_and_conditions/terms_and_conditions.dart';

//TODO: o chiamarli tutti screen o chiamarli tutti pages!
//TODO: Add onboarding screen

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/': 
      case '/home': //TODO: remove
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/splash': //TODO: settare lo splash screen come '/'?
        return MaterialPageRoute(builder: (_) => SplashScreen()); //TODO: prima era Splash
      case '/myplants':
        return MaterialPageRoute(builder: (_) => MyPlantsScreen());
      case '/myplants/details':
        //return MaterialPageRoute(builder: (_) => PlantDetails(plant: args);
        if(args is Plant) {
          return MaterialPageRoute(
            builder: (_) => PlantDetails(plant: args)
          );
        }
        return _errorRoute();
      case '/tasks':
        return MaterialPageRoute(builder: (_) => TasksScreen());
      case '/diagnosis':
        return MaterialPageRoute(builder: (_) => DiagnosisScreen());
      case '/diagnosis/scan/result':
        if(args is PlantDisease) {
          return MaterialPageRoute(
            builder: (_) => DiagnosisScanResultScreen(plantDisease: args)
          );
        }
        return _errorRoute();
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/scan':
        return MaterialPageRoute(builder: (_) => ScanPage());
      case '/scan/result':
        if(args is Plant) {
          return MaterialPageRoute(
            builder: (_) => ScanResultScreen(plant: args) //TODO: ScanResultPage
          );
        }
        return _errorRoute();

      case '/diagnosis/scan/result': //TODO: remove
        if(args is Plant) {
          //TODO: uncomment
          /*return MaterialPageRoute(
            builder: (_) => ScanResultScreen(plant: args) //TODO: DiagnosisScanResultPage
          );*/
        }
        return _errorRoute();
      case '/sensors':
        return MaterialPageRoute(builder: (_) => const SensorPage());
      case '/privacy/policy':
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
      case '/terms/conditions':
        return MaterialPageRoute(builder: (_) => const TermsAndConditionsPage());
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
