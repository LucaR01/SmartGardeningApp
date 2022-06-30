import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_gardening_app/models/plant/plant.dart';

import '../screens/home/home_screen.dart';
import '../screens/pages.dart';

class Utils {
  //TODO: magari cambiare il valore di default dello shouldPop in false al posto di true.
  static void navigateToPage({required BuildContext context, required Pages page, bool shouldPop = false, 
  Plant? plant}) {
  
	//TODO: final bool shouldPop;
	//TODO: (...,this.shouldPop)

    if(shouldPop){
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
      case Pages.scanResult:
        Navigator.of(context).pushReplacementNamed('/scan_result', arguments: plant);
        break;
      default:
        //TODO: forse non serve il default.
        Navigator.of(context).pushNamed('/');
        break;
    }
  }

  //TODO: remove?
  static Future<File?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source); //TODO: Questo da eccezione!
      if(image == null) return null;

      final tempImage = File(image.path);

      //_detectImage(tempImage); //TODO: remove

      /*setState(() {
        this.image = tempImage;
      });*/ // () => this.image = tempImage 

      //_detectImage(tempImage);

      return tempImage;

    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }

    return null;
  }
}