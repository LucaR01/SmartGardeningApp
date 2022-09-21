import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_prova/models/plant/plant_disease.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/provider/theme_provider.dart';
import 'package:flutter_application_prova/themes/themes.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:tflite/tflite.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  File? image;

  //late Plant sickPlant;
  List _outputs = [];
  bool _loading = false;

  PlantDisease? plantDisease; //TODO: prima era late PlantDisease plantDisease;

  @override
  void initState() {
    super.initState();
    /*_loadModel().then((value) { //TODO: uncomment or remove
      setState(() {
        _loading = false;
      });
    });*/
    print("initState()"); //TODO: remove
    _loadModel(); 
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: source); //TODO: Questo da eccezione!
      if (image == null) return;

      final tempImage = File(image.path);

      //_detectImage(tempImage); //TODO: remove

      setState(() {
        this.image = tempImage;
      }); // () => this.image = tempImage

      _detectImage(tempImage);

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  _loadModel() async { //TODO: uncomment
    await Tflite.loadModel(
      model: 'assets/plants_diseases/model_unquant.tflite', 
      labels: 'assets/plants_diseases/labels.txt', 
    );
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
    
    //TODO: remove setState?
    setState(() {

      print("output: ${output}"); //TODO: remove

      String str = output![0]["label"];

      print("str: ${str}"); //TODO: remove

      String _name = str.substring(2); //TODO: put in class

      print("name: ${_name}"); //TODO: remove

      //TODO: rename in accuracy
      //String _confidence = output != null ? (output[0]["confidence"]*100.0).toString().substring(0, 2) + "%" : "";

      //print("confidence/accuracy: ${_name}"); //TODO: remove

      //TODO: scannedPlant = Plant();

    });

    plantDisease = PlantDisease(name: output![0]["label"].toString().substring(2), diseaseConfidence: output[0]["confidence"]);
    //Utils.navigateToPage(context: context, page: Pages.diagnosisScanResult, plantDisease: plantDisease); //TODO: remove
  }

  @override
  Widget build(BuildContext context) {
    //final text = Provider.of<ThemeProvider>(context).themeMode == Brightness.dark ? 'DarkTheme' : 'LightTheme';

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      appBar: const AppBarWidget(),
      bottomNavigationBar: const CustomBottomNavigationBar(), //BottomNavigationBarWidget(), //TODO: CustomBottomNavigationBar?
      body: SingleChildScrollView (
        child: Center(
          child: Column(
            children: [
              image != null ? Image.file(image!) : const Image(image: AssetImage("assets/images/camera-focus-frame-objective-photo.png")),
              Text(plantDisease == null ? '' : '${AppLocalizations.of(context).disease}: ${plantDisease!.name}'), //TODO: plantDisease.name.isEmpty ? //TODO: aggiungere textStyle?
              Text(plantDisease == null ? '' : '${AppLocalizations.of(context).confidence}: ${(plantDisease!.diseaseConfidence * 100.0).toString()}%'), //TODO: plantDisease.diseaseAccuracy.isNaN //TODO: aggiungere textStyle? 
              Text(
                plantDisease == null ? AppLocalizations.of(context).position_in_the_center : '', //TODO: remove text $text 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              //ElevatedButton(child: Text("Prova"), onPressed: () => { plantDisease = PlantDisease(name: 'Common Corn Rust', diseaseConfidence: 98.7) }), //TODO: remove just for testing
              const SizedBox(height: 20),
              //_buildButton(label: AppLocalizations.of(context).pick_image_from_gallery, icon: Icons.image, onPressed: () => pickImage(ImageSource.gallery) ), //TODO: fix or remove
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.gallery), //TODO: async?
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
              //ElevatedButton.icon(onPressed: () => pickImage(ImageSource.gallery), icon: const Icon(Icons.image), label: Text('Gallery')), //TODO: 
              const SizedBox(height: 10),
              //_buildButton(label: AppLocalizations.of(context).pick_image_from_camera, icon: Icons.camera_alt_outlined, onPressed: () => pickImage(ImageSource.camera)), //TODO: fix or remove
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.camera), //TODO: async?
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
