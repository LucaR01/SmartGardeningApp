import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/plant/plant_disease.dart';
import 'package:flutter_application_prova/screens/pages.dart';

import 'package:flutter_application_prova/models/plant/plant.dart';

class Utils {
  
  /// It allows to move from a page to another.
  /// [shouldPop] permits to close the navigation drawer and what was open in the old page before the move.
  /// [Plant] and [PlantDisease] are only needed for certain pages which require an argument as parameter like
  /// [Pages.myPlantsDetails] and [Pages.scanResult].
  static void navigateToPage(
      {required BuildContext context,
      required Pages page,
      bool shouldPop = false,
      Plant? plant,
      PlantDisease? plantDisease}) {

    if (shouldPop) {
      Navigator.of(context).pop(); // Così si chiude il navigation drawer, ma per la bottom navigation bar non serve.
    }

    switch (page) {
      case Pages.home:
        Navigator.of(context).pushReplacementNamed('/');
        break;
      case Pages.myPlants:
        Navigator.of(context).pushNamed('/myplants');
        break;
      case Pages.myPlantsDetails:
        Navigator.of(context).pushNamed('/myplants/details', arguments: plant);
        break;
      case Pages.diagnosis:
        Navigator.of(context).pushNamed('/diagnosis');
        break;
      case Pages.settings:
        Navigator.of(context).pushNamed('/settings');
        break;
      /*case Pages.notifications: //TODO: remove
        //Navigator.of(context).pushNamed('/');
        break;*/
      case Pages.privacyPolicy:
        Navigator.of(context).pushNamed('/privacy/policy');
        break;
      case Pages.termsAndConditions:
        Navigator.of(context).pushNamed('/terms/conditions');
        break;
      case Pages.scan:
        Navigator.of(context).pushNamed('/scan');
        break;
      case Pages.scanResult:
        Navigator.of(context).pushReplacementNamed('/scan/result', arguments: plant);
        break;
      case Pages.sensors:
        Navigator.of(context).pushNamed('/sensors');
        break;
      default:
        // forse non serve il default.
        Navigator.of(context).pushNamed('/');
        break;
    }
  }

}
