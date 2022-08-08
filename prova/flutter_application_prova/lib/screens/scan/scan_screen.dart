import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';

import 'package:tflite/tflite.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  List _outputs = [];
  bool _loading = false;

  //late Plant _scannedPlant; //TODO: uncomment

  String _scannedPlantName = "";

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
    _loadModel();
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

    setState(() {
      _loading = false;

      _scannedPlantName = output![0]["label"];

      print('output: ${output}');

      print('_scannedPlantName: ${_scannedPlantName}');

      _outputs = output;

      print(_outputs);
      print(output);

      //_outputs.add(output);

      print("output: ${output}"); //TODO: remove

      String str = output[0]["label"];

      print("str: ${str}"); //TODO: remove

      String _name = str.substring(2); //TODO: put in class

      _scannedPlantName = _name;

      print("name: ${_name}"); //TODO: remove

      //TODO: rename in accuracy
      //String _confidence = output != null ? (output[0]["confidence"]*100.0).toString().substring(0, 2) + "%" : "";

      //print("confidence/accuracy: ${_name}"); //TODO: remove

      //TODO: scannedPlant = Plant();

    });

    print(_scannedPlantName);
    print(output);
    print(_outputs);

    
  }

  //TODO: remove
  temp() {
    final tempImage = File('assets/images/scan/gelsomono_mamertino.png');
    print('temp(): tempImage: ${tempImage}');
    _detectImage(tempImage);
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
              Utils.buildButton(label: AppLocalizations.of(context).pick_image_from_gallery, icon: Icons.image, onPressed: () => pickImage(ImageSource.gallery)),
              const SizedBox(height: 10),
              Utils.buildButton(label: AppLocalizations.of(context).pick_image_from_camera, icon: Icons.camera_alt_outlined, onPressed: () => pickImage(ImageSource.camera)),
              Text( //TODO: remove
                _scannedPlantName,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              IconButton(
                onPressed: () {}, //pickImage(ImageSource.gallery), //TODO: rimettere questo
                icon: const Icon(Icons.scanner),
              )
            ],
          ),
        ),
      ),
    );
  }
}
