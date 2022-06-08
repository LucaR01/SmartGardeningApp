import 'package:flutter/material.dart';
import 'package:smart_gardening_app/widgets/FAB/FABWidget.dart';
import 'package:smart_gardening_app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';

import '../../widgets/app_bar/app_bar.dart';

//TODO: scan_screens/scan_screen/
//TODO: scan_screens/scan_result_screen/

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      appBar: const AppBarWidget(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const Image(
                image: AssetImage(
                    "assets/images/camera-focus-frame-objective-photo.png"),
                    //width: 256, //TODO: remove?
              ),
              const Text(
                "Posizionare la pianta al centro del riquadro.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.scanner), //TODO: update icon
                ),
              const Text(
                'Scan',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              /*ElevatedButton(
                onPressed: (){}, 
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.scanner),
                ),
                )*/
            ],
          ),
        ),
      ),
    );
  }
}
