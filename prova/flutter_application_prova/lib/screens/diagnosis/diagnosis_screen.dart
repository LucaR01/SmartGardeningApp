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

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  File? image;

  //late Plant sickPlant;

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

      //_detectImage(tempImage);

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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
              MaterialButton(
                color: Colors.green[600], //TODO: use color constants
                child: const Text(
                  'Pick Image from Gallery',
                  style: TextStyle(
                    color: Colors.white, //TODO: use color constants
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  pickImage(ImageSource.gallery);
                  //print(image); //TODO: remove
                },
              ),
              const SizedBox(height: 10),
              /*_buildButton(text: 'Pick Image from Gallery', icon: Icons.image_outlined, onClick: () => pickImage(ImageSource.gallery)),
              const SizedBox(height: 10),
              Utils.buildImagePickerButton(text: 'Pick Image from Camera', icon: Icons.camera, onClick: () => pickImage(ImageSource.camera)),
              _buildCustomButton(text: 'Pick Image from Gallery', icon: Icons.image_outlined, onClick: () => pickImage(ImageSource.gallery)), //TODO: remove*/
              MaterialButton(
                color: Colors.green[600], //TODO: use color constants
                child: const Text(
                  'Pick Image from Camera',
                  style: TextStyle(
                    color: Colors.white, //TODO: use color constants
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //onPressed: () => Utils.pickImage(ImageSource.camera) != null ? image = Utils.pickImage(ImageSource.camera) as File? : null, //TODO: remove
                onPressed: () {
                  //image = Utils.pickImage(ImageSource.camera) as File?;
                  pickImage(ImageSource.camera);
                  //print(image); //TODO: remove
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: remove?
Widget _buildButton(
  {
    required String text,
    required IconData icon,
    required VoidCallback onClick,
  }
) {
  return Container(
    width: 240,
    color: Colors.green,
    child: ElevatedButton(
      onPressed: () => onClick,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 20),
          Text(
              text,
              style: TextStyle(
                color: Colors.white, //TODO: use color constants
                fontWeight: FontWeight.bold,
              ),
          ),
        ],
      ),
    ),
  );
}

//TODO: remove
Widget _buildCustomButton(
  {
    required String text,
    required IconData icon,
    required VoidCallback onClick,
  }
) {
  return MaterialButton(
    color: Colors.green[600], //TODO: use color constants
    onPressed: () => onClick,
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white, //TODO: use color constants
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
