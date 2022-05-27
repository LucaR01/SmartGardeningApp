import 'package:flutter/material.dart';

import 'home_header.dart';

//TODO: stateless widget con SafeArea.
//TODO: rename in home_body? or body_home?
//TODO: rename class in HomeBody? or HomeScreenBody, HomePageBody?

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return SafeArea( //TODO: remove/fix
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(),
          ],
          )
      )
    );*/
    return HomeHeader();
  }
}