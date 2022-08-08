import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:flutter_application_prova/widgets/drawer/navigation_drawer.dart';

import '../../../widgets/FAB/FABWidget.dart';
import '../../../widgets/app_bar/app_bar.dart';
import '../../../widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green[100], //TODO: remove
      drawer: const NavigationDrawerWidget(), // È il menù.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      appBar: const AppBarWidget(), //TODO: uncomment
      /*appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.black, //TODO: update
          ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true, //TODO: update
        title: const Text("Smart Gardening App"), //TODO: usare le costants.
        actions: const [
          Padding(
            padding: EdgeInsets.all(9), //TODO: 8
            child: Icon(
              Icons.document_scanner,
              ) //TODO: update e mettere l'icona scan.
          )
        ],
      ),*/

    );
  }
}