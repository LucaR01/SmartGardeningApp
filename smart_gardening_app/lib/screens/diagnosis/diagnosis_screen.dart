import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_gardening_app/utils/utils.dart';
import 'package:smart_gardening_app/widgets/FAB/FABWidget.dart';
import 'package:smart_gardening_app/widgets/app_bar/app_bar.dart';
import 'package:smart_gardening_app/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  File? image;

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

  @override
  Widget build(BuildContext context) {
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
              const Text(
                'Posizionare la pianta al centro del riquadro.',
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
