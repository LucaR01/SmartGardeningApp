import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_application_prova/api/plant_api/plant_api.dart';
import 'package:flutter_application_prova/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';

import 'package:tflite/tflite.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:developer';

//TODO: aggiungere animazione per il caricamento del risultato.

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  File? image;

  final List _outputs = [];

  Plant? scannedPlant;

  double _confidence = 0.0;

  @override
  void initState() {
    super.initState();
    /*_loadModel().then((value) { //TODO: uncomment
      setState(() {
        _loading = false;
      });
    });*/
    print("initState()"); //TODO: remove
    _loadModel(); 
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  _loadModel() async { 
    await Tflite.loadModel(
      model: "assets/plants/model_unquant.tflite", 
      labels: "assets/plants/labels.txt", 
    );
    print('loading model...');
  }

  _detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true
    );

    print('output: ${output}');
    print(output);
    print(_outputs);

    print('output[0]["label"].toString().substring(2): ${output![0]["label"].toString().substring(2)}');
    print('output[0]["confidence"]: ${output[0]["confidence"]}');

    String accuracy = output != null ? (output[0]["confidence"]*100.0).toString().substring(0, 2) + "%" : "";
    print("accuracy in %: ${accuracy}");

    scannedPlant = await PlantAPI.getData(plantPID: output[0]["label"].toString().substring(2), accuracy: output[0]["confidence"]);
    
    scannedPlant != null ? scannedPlant!.imageUrl = image.path : {};

    inspect(scannedPlant); //TODO: remove

    //TODO: localizations
    scannedPlant == null ? SnackBarMessageWidget.snackBarMessage(context: context, title: 'Error', msg: 'Unable to retrieve plant\'s data', errorCode: ErrorCodes.error) : Utils.navigateToPage(context: context, page: Pages.scanResult, plant: scannedPlant);
    
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;

      final tempImage = File(image.path);

      print('tempImage: ${tempImage}');

      setState(() {
        this.image = tempImage;
      }); // () => this.image = tempImage 

      _detectImage(tempImage); 

    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      appBar: const AppBarWidget(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage(
                    "assets/images/camera-focus-frame-objective-photo.png"),
              ),
              Text(
                AppLocalizations.of(context).position_in_the_center,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color, 
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              //ElevatedButton(onPressed: () async { Plant p = (await PlantAPI.getData(plantPID: 'jasminum floridum', accuracy: 92.3))!; Utils.navigateToPage(context: context, page: Pages.scanResult, plant: p); }, child: Text('Test Pianta'),), //TODO: remove
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.gallery),
                label: Text(
                  AppLocalizations.of(context).pick_image_from_gallery,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: Theme.of(context).elevatedButtonTheme.style,
                icon: Icon(Icons.image, color: Theme.of(context).iconTheme.color),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.camera),
                label: Text(
                  AppLocalizations.of(context).pick_image_from_camera,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: Theme.of(context).elevatedButtonTheme.style,
                icon: Icon(Icons.camera_alt_outlined, color: Theme.of(context).iconTheme.color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: remove
  Widget _buildButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
    ButtonStyle? style, //TODO: questo non lo sto usando!
  }) {
    return ElevatedButton.icon(
    onPressed: () async { onPressed; },
    label: Text(
      label,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1!.color,
        fontWeight: FontWeight.bold,
      ),
    ),
    style: ElevatedButton.styleFrom(
      primary: Theme.of(context).primaryColor, 
      onPrimary: Theme.of(context).textTheme.bodyText1!.color,
    ),
    icon: Icon(icon),
    );
  }
}
