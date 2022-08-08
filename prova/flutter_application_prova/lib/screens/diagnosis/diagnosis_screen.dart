import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      model: 'assets/plants/model_unquant.tflite', //TODO: 
      labels: 'assets/plants/labels.txt', //TODO: 
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
  }

  @override
  Widget build(BuildContext context) {
    //final text = Provider.of<ThemeProvider>(context).themeMode == Brightness.dark ? 'DarkTheme' : 'LightTheme';

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      appBar: const AppBarWidget(),
      bottomNavigationBar: const BottomNavigationBarWidget(), //TODO: CustomBottomNavigationBar?
      body: SingleChildScrollView (
        child: Center(
          child: Column(
            children: [
              const Image(
                image: AssetImage(
                    "assets/images/camera-focus-frame-objective-photo.png"),
                //width: 256, //TODO: remove?
              ),
              Text(
                'Posizionare la pianta al centro del riquadro.', //TODO: remove text $text
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Utils.buildButton(label: 'Pick Image from Gallery', icon: Icons.image, onPressed: () => pickImage(ImageSource.gallery)),
              const SizedBox(height: 10),
              Utils.buildButton(label: 'Pick Image from Camera', icon: Icons.camera_alt_outlined, onPressed: () => pickImage(ImageSource.camera)),
            ],
          ),
        ),
      ),
    );
  }
}
