import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:camera/camera.dart'; //TODO: remove
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_gardening_app/models/plant/plant.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:smart_gardening_app/screens/pages.dart';
import 'package:smart_gardening_app/utils/utils.dart';

import 'package:smart_gardening_app/widgets/FAB/FABWidget.dart';
import 'package:smart_gardening_app/widgets/app_bar/app_bar.dart';
import 'package:smart_gardening_app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:tflite/tflite.dart';

//TODO: scan_screens/scan_screen/
//TODO: scan_screens/scan_result_screen/

//TODO: Add pick image from gallery

//TODO: aggiungere animazione per il caricamento del risultato.

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  File? image;
  final _picker = ImagePicker();

  late List _outputs;
  bool _loading = false;

  /*Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }*/

  @override
  void initState() {
    super.initState();
    _loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    Tflite.close(); //TODO: remove?
    super.dispose();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source); //TODO: Questo da eccezione!
      if(image == null) return;

      final tempImage = File(image.path);
      setState(() {
        this.image = tempImage;
      }); // () => this.image = tempImage 

      _detectImage(tempImage);

    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }

  _loadModel() async {
    await Tflite.loadModel(
      model: 'assets/plants/plant_model.tflite', //TODO: 
      labels: 'assets/plants/plant_labels.txt', //TODO: 
    );
  }

  //TODO: rename in detectPlant?
  _detectImage(File image) async {
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
      _outputs = output!;
      //_outputs.add(output);

      print("output: ${output}"); //TODO: remove

      String str = output[0]["label"];

      print("str: ${str}"); //TODO: remove

      String _name = str.substring(2); //TODO: put in class

      print("name: ${_name}"); //TODO: remove

      //TODO: rename in accuracy
      //String _confidence = output != null ? (output[0]["confidence"]*100.0).toString().substring(0, 2) + "%" : "";

      //print("confidence/accuracy: ${_name}"); //TODO: remove

    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      appBar: const AppBarWidget(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SafeArea(
        child: Center(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true), //ScrollConfiguration.of(context).copyWith(scrollbars: false), //TODO: 
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage(
                        "assets/images/camera-focus-frame-objective-photo.png"),
                        //width: 256, //TODO: remove?
                  ),
                  //cameraPreview(), //TODO: remove
                  const Text(
                    "Posizionare la pianta al centro del riquadro.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.scanner), //TODO: update icon
                    onPressed: () => Utils.navigateToPage(context: context, page: Pages.scanResult, plant: _getScannedPlant()), //TODO: pickImage(ImageSource.camera), 
                    ),
                  const Text(
                    'Scan',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.gallery), 
                    child: IconButton(
                      onPressed: () => pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.scanner),
                    ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //TODO: in questo metodo dovrò scannerizzare la pianta e restituirla così poi da poterla passare allo scan result screen
  //TODO: ora sto soltanto restituendo una pianta creata a caso.
  Plant _getScannedPlant() {
    return Plant(name: 'Conifera', family: '', description: '', img: '', otherDescription: '', plantAccuracy: 83.9, sunAmount: 12, waterAmount: 4 );
  }
}
