import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_application_prova/api/notifications/notifications_api.dart';
import 'package:flutter_application_prova/api/plant_api/plant_api.dart';
import 'package:flutter_application_prova/api/sensor_api/sensor_api.dart';
import 'package:flutter_application_prova/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';
import 'package:flutter_application_prova/models/aircare_sensor/aircare_sensor.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';

import 'package:tflite/tflite.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:developer';

//TODO: scan_screens/scan_screen/
//TODO: scan_screens/scan_result_screen/

//TODO: aggiungere animazione per il caricamento del risultato.

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  File? image;

  List _outputs = [];

  Plant? scannedPlant;

  double _confidence = 0.0;

  //TODO: uncomment
  @override
  void initState() {
    super.initState();
    /*_loadModel().then((value) { //TODO: uncomment
      setState(() {
        _loading = false;
      });
    });*/
    print("initState()"); //TODO: remove
    _loadModel(); //TODO: uncomment
  }

  @override
  void dispose() {
    Tflite.close(); //TODO: remove?
    super.dispose();
  }

  _loadModel() async { //TODO: uncomment
    await Tflite.loadModel(
      model: "assets/plants/model_unquant.tflite", //TODO: assets/plants/model_unquant.tflite ; D:\\Documenti\\Flutter\\SmartGardeningApp\\smart_gardening_app\\assets\\plants\\model_unquant.tflite
      labels: "assets/plants/labels.txt", //TODO: assets/plants/labels.txt ;
    );
    print('loading model...');
  }

  //TODO: rename in detectPlant?
  _detectImage(File image) async { //TODO: uncomment
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

    //TODO: controllare se serve il .substring(2)
    scannedPlant = (await PlantAPI.getData(plantPID: output[0]["label"].toString().substring(2), accuracy: output[0]["confidence"]))!;
    
    scannedPlant == null ? {} : scannedPlant!.imageUrl = image.path;

    inspect(scannedPlant); //TODO: remove

    //TODO: Il title e msg dello SnackBar devono essere tradotti
    scannedPlant == null ? SnackBarMessageWidget.snackBarMessage(context: context, title: 'Error', msg: 'Unable to retrieve plant\'s data', errorCode: ErrorCodes.error) : Utils.navigateToPage(context: context, page: Pages.scanResult, plant: scannedPlant);

    //TODO: la pianta scannerizzata va aggiunta alla lista di piante scannerizzate o attraverso un database o attraverso shared preferences.
    //_scannedPlant = Plant(accuracy: output![0]["confidence"], alias: '', displayPid: '', imageUrl: '', maxEnvHumid: 0, maxLightLux: 0, maxLightMmol: 0, maxSoilEC: 0, maxSoilMoist: 0, maxTemp: 0, minEnvHumid: 0, minLightLux: 0, minLightMmol: 0, minSoilEC: 0, minSoilMoist: 0, minTemp: 0, pid: '' ); 
    
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source); //TODO: Questo da eccezione!
      if(image == null) return;

      final tempImage = File(image.path);

      print('tempImage: ${tempImage}');

      //_detectImage(tempImage); //TODO: remove

      setState(() {
        this.image = tempImage;
      }); // () => this.image = tempImage 

      _detectImage(tempImage); //TODO: uncomment

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
                "Posizionare la pianta al centro del riquadro.", //TODO: use localization
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () async { Plant p = (await PlantAPI.getData(plantPID: 'jasminum floridum', accuracy: 92.3))!; Utils.navigateToPage(context: context, page: Pages.scanResult, plant: p); }, child: Text('hello2'),), //TODO: remove
              _buildButton(label: AppLocalizations.of(context).pick_image_from_gallery, icon: Icons.image, onPressed: () => pickImage(ImageSource.gallery)),
              ElevatedButton(onPressed: () => pickImage(ImageSource.gallery), child: Text('Gallery')),
              const SizedBox(height: 10),
              _buildButton(label: AppLocalizations.of(context).pick_image_from_camera, icon: Icons.camera_alt_outlined, onPressed: () => pickImage(ImageSource.camera)), 
              ElevatedButton(onPressed: () { NotificationsAPI.showNotification(title: 'Notifica', body: 'Prova notifica', payload: 'prova.abs'); }, child: Text('Notifiche')), //TODO: remove, just for testing
              /*Text( //TODO: remove
                '',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
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
}
