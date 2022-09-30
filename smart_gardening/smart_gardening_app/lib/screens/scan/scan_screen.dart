import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:smart_gardening_app/api/plant_api/plant_api.dart';
import 'package:smart_gardening_app/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:smart_gardening_app/api/snackbar_messages/error_codes.dart';
import 'package:smart_gardening_app/constants/constants.dart';
import 'package:smart_gardening_app/models/plant/plant.dart';
import 'package:smart_gardening_app/provider/locale_provider.dart';
import 'package:smart_gardening_app/screens/loading/loading.dart';
import 'package:smart_gardening_app/screens/pages.dart';
import 'package:smart_gardening_app/utils/utils.dart';
import 'package:smart_gardening_app/widgets/FAB/FABWidget.dart';
import 'package:smart_gardening_app/widgets/app_bar/app_bar.dart';
import 'package:smart_gardening_app/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:tflite/tflite.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:io';
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

  /// It loads the tflite model of the plants.
  _loadModel() async { 
    await Tflite.loadModel(
      model: "assets/plants/model_unquant.tflite", 
      labels: "assets/plants/labels.txt", 
    );
    print('loading model...');
  }

  /// It runs the model on the [image] passed as argument.
  /// If the API ([PlantAPI.getData]) has found a match of the [Plant.pid] passed then it saves the data in [scannedPlant].
  /// [Plant.imageUrl] is updated with the image passed by the user ([image] path) instead of the one retrieved from the API.
  /// If [scannedPlant] is null, then it shows a [SnackBarMessageWidget] with an [ErrorCodes.error]
  /// otherwise it calls [Utils.navigateToPage] to move to page: [Pages.scanResult].
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

    //inspect(scannedPlant); //TODO: remove or keep just for testing

    scannedPlant == null ? SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).error, msg: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode == Constants.englishLangCode ? '${AppLocalizations.of(context).unable_to_retrieve} ${AppLocalizations.of(context).plant_saxon_genitive} ${AppLocalizations.of(context).data}' : '${AppLocalizations.of(context).unable_to_retrieve} ${AppLocalizations.of(context).data} ${AppLocalizations.of(context).plant_saxon_genitive}', errorCode: ErrorCodes.error) : Utils.navigateToPage(context: context, page: Pages.scanResult, plant: scannedPlant);
    
  }

  /// When the user press [ElevatedButton] with the corresponding [ImageSource.camera] or [ImageSource.gallery] this function is called
  /// and it retrieves the [image] selected from the user either by the camera or by the gallery and calls [_detectImage].
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
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage(
                    "assets/images/camera_focus/camera-focus-frame-objective-photo.png"),
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
              //ElevatedButton(onPressed: () async { Plant p = (await PlantAPI.getData(plantPID: 'jasminum floridum', accuracy: 92.3))!; Utils.navigateToPage(context: context, page: Pages.scanResult, plant: p); }, child: Text('Test Pianta'),), //TODO: remove or just keep for testing
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
