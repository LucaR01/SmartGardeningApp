import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_prova/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';
import 'package:flutter_application_prova/constants/constants.dart';
import 'package:flutter_application_prova/models/plant/plant_disease.dart';
import 'package:flutter_application_prova/provider/locale_provider.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  File? image;

  final List _outputs = [];
  final bool _loading = false;

  PlantDisease? plantDisease;

  @override
  void initState() {
    super.initState();
    print("initState()"); //TODO: remove
    _loadModel(); 
  }

  /// When the user press [ElevatedButton] with the corresponding [ImageSource.camera] or [ImageSource.gallery] this function is called
  /// and it retrieves the [image] selected from the user either by the camera or by the gallery and calls [_detectImage].
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source); 
      if (image == null) return;

      final tempImage = File(image.path);

      setState(() {
        this.image = tempImage;
      }); // () => this.image = tempImage

      _detectImage(tempImage);

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  /// It loads the tflite model of the plants' diseases.
  _loadModel() async {
    await Tflite.loadModel(
      model: 'assets/plants_diseases/model_unquant.tflite', 
      labels: 'assets/plants_diseases/labels.txt', 
    );
  }

  /// It runs the model on the [image] passed as argument.
  /// It creates a new [PlantDisease] and passes the name retrieved from the [output] of the [runModelOnImage].
  /// If [plantDisease] is not null, it updates the [build] with [setState] and it shows [plantDisease.name] and 
  /// [plantDisease.diseaseConfidence] on the screen.
  /// If [plantDisease] is null, it shows a [SnackBarMessageWidget] with an [ErrorCodes.error],
  /// otherwise it doesn't do anything.
  _detectImage(File image) async { 
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true
    );
    
    //TODO: remove setState?
    setState(() {});

    plantDisease = PlantDisease(name: output![0]["label"].toString().substring(2), diseaseConfidence: output[0]["confidence"]);

    //TODO: credo quasi non serva questo controllo e messaggio, ma vabbè.
    plantDisease == null ? SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).error, msg: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode == Constants.englishLangCode ? '${AppLocalizations.of(context).unable_to_retrieve} ${AppLocalizations.of(context).plant_saxon_genitive} ${AppLocalizations.of(context).data}' : '${AppLocalizations.of(context).unable_to_retrieve} ${AppLocalizations.of(context).data} ${AppLocalizations.of(context).plant_saxon_genitive}', errorCode: ErrorCodes.error) : {};
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      appBar: const AppBarWidget(),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: SingleChildScrollView (
        child: Center(
          child: Column(
            children: [
              image != null ? Image.file(image!) : const Image(image: AssetImage("assets/images/camera_focus/camera-focus-frame-objective-photo.png")),
              Text(plantDisease == null ? '' : '${AppLocalizations.of(context).disease}: ${plantDisease!.name}', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),),
              Text(plantDisease == null ? '' : '${AppLocalizations.of(context).confidence}: ${(plantDisease!.diseaseConfidence * 100.0).toString()}%', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),),
              Text(
                plantDisease == null ? AppLocalizations.of(context).position_in_the_center : '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              const SizedBox(height: 20),
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

  //TODO: remove or fix
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
      onPrimary: Theme.of(context).textTheme.bodyText1!.color, //TODO: controllare il colore
    ),
    icon: Icon(icon),
    );
  }
}
