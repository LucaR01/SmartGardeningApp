import 'package:flutter/material.dart';

import '../../splash/splash_screen.dart';
import 'home_header.dart';

//TODO: stateless widget con SafeArea.
//TODO: rename in home_body? or body_home?
//TODO: rename class in HomeBody? or HomeScreenBody, HomePageBody?

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return SafeArea( //TODO: remove/fix //TODO: Scaffold( SafeArea: )
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 120.0),
            HomeHeader(),
          ],
          )
      )
    );*/
    return HomeHeader(); //TODO: aggiungere anche le altre pagine.
  }
}