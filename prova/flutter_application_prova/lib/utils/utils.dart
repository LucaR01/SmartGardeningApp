import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_prova/models/plant/plant_disease.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_application_prova/models/plant/plant.dart';

class Utils {
  //TODO: magari cambiare il valore di default dello shouldPop in false al posto di true.
  static void navigateToPage(
      {required BuildContext context,
      required Pages page,
      bool shouldPop = false,
      Plant? plant,
      PlantDisease? plantDisease}) {
    //TODO: final bool shouldPop;
    //TODO: (...,this.shouldPop)

    if (shouldPop) {
      Navigator.of(context)
          .pop(); // Così si chiude il navigation drawer, ma per la bottom navigation bar non serve.
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
      case Pages.diagnosisScanResult:
        Navigator.pushReplacementNamed(context, '/diagnosis/scan/result');
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
        Navigator.of(context)
            .pushReplacementNamed('/scan/result', arguments: plant);
        break;
      case Pages.sensors:
        Navigator.of(context).pushNamed('/sensors');
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
      final image = await ImagePicker()
          .pickImage(source: source); //TODO: Questo da eccezione!
      if (image == null) return null;

      final tempImage = File(image.path);

      //_detectImage(tempImage); //TODO: remove

      /*setState(() {
        this.image = tempImage;
      });*/ // () => this.image = tempImage

      //_detectImage(tempImage);

      return tempImage;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }

    return null;
  }

  //TODO: remove?
  static Widget buildButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
    ButtonStyle? style, //TODO: questo non lo sto usando!
  }) {
    return ElevatedButton.icon(
    onPressed: () => onPressed,
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white, //TODO: use color constants
        fontWeight: FontWeight.bold,
      ),
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.green[600], //[900] TODO: use color constants and themeColor
      onPrimary: Colors.white, //TODO: use color constants and themeColor
    ),
    icon: Icon(icon),
    );
  }

  /*_loadModel() async { //TODO: uncomment
    await Tflite.loadModel(
      model: 'assets/plants/model_unquant.tflite', //TODO: 
      labels: 'assets/plants/labels.txt', //TODO: 
    );
  }*/

  //TODO: rename in detectPlant?
  /*_detectImage(File image) async { //TODO: uncomment
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true
    );
    setState(() {
      _loading = false;

      _scannedPlantName = output![0]["label"];

      print(_scannedPlantName);

      _outputs = output;

      print(_outputs);
      print(output);

      //_outputs.add(output);

      print("output: ${output}"); //TODO: remove

      String str = output[0]["label"];

      print("str: ${str}"); //TODO: remove

      String _name = str.substring(2); //TODO: put in class

      print("name: ${_name}"); //TODO: remove

      //TODO: rename in accuracy
      //String _confidence = output != null ? (output[0]["confidence"]*100.0).toString().substring(0, 2) + "%" : "";

      //print("confidence/accuracy: ${_name}"); //TODO: remove

      //TODO: scannedPlant = Plant();

    });

    print(_scannedPlantName);
    print(output);
    print(_outputs);

    
  }*/
}
