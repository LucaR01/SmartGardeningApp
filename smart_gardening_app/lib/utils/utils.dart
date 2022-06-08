import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import '../screens/pages.dart';

class Utils {
  //TODO: magari cambiare il valore di default dello shouldPop in false al posto di true.
  static void navigateToPage({required BuildContext context, required Pages page, bool shouldPop = false}) {
  
	//TODO: final bool shouldPop;
	//TODO: (...,this.shouldPop)

    if(shouldPop){
      Navigator.of(context).pop(); // Così si chiude il navigation drawer, ma per la bottom navigation bar non serve.
    }

    switch (page) {
      case Pages.home:
        Navigator.of(context).pushNamed('/');
        break;
      case Pages.myPlants:
        Navigator.of(context).pushNamed('/myplants'); 
        break;
      case Pages.tasks:
        Navigator.of(context).pushNamed('/tasks'); 
        break;
      case Pages.diagnosis:
        Navigator.of(context).pushNamed('/diagnosis'); 
        break;
      case Pages.settings:
        Navigator.of(context).pushNamed('/settings');
        break;
      case Pages.notifications:
        //Navigator.of(context).pushNamed('/'); //TODO: uncomment
        break;
      case Pages.privacyPolicy:
        //Navigator.of(context).pushNamed('/'); //TODO: uncomment
        break;
      case Pages.scan:
        Navigator.of(context).pushNamed('/scan');
        break;
      default:
        //TODO: forse non serve il default.
        Navigator.of(context).pushNamed('/home');
        break;
    }
  }
}