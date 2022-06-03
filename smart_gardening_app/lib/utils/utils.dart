import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import '../screens/pages.dart';

class Utils {
  //TODO: rename in switchPage, goToPage
  static void navigateToPage({required BuildContext context, required Pages page, bool shouldPop = true}) {

    if(shouldPop){
      Navigator.of(context).pop(); // Così si chiude il navigation drawer.
    }

    switch (page) {
      case Pages.home:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));*/
        Navigator.of(context).pushNamed('/home');
        break;
      case Pages.myPlants:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        Navigator.of(context).pushNamed('/myplants'); 
        break;
      case Pages.tasks:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        Navigator.of(context).pushNamed('/tasks'); 
        break;
      case Pages.diagnosis:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        Navigator.of(context).pushNamed('/diagnosis'); 
        break;
      case Pages.settings:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        Navigator.of(context).pushNamed('/settings');
        break;
      case Pages.notifications:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        //Navigator.of(context).pushNamed('/'); //TODO: uncomment
        break;
      case Pages.privacyPolicy:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        //Navigator.of(context).pushNamed('/'); //TODO: uncomment
        break;
      default:
        //TODO: forse non serve il default.
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        Navigator.of(context).pushNamed('/home');
        break;
    }
  }
}