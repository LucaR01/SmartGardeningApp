import 'package:flutter/material.dart';

import 'components/body.dart';

//TODO: rinominare la cartella 'screens' in 'pages'?

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(), //TODO: uncomment
      /*backgroundColor: Colors.green, //TODO: change color
      bottomNavigationBar: null, //TODO: update
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: appBar
              //TODO: AnotherSection
              //TODO: SizedBox
              //TODO: another section
            ],
            )
        ],
      ),*/
    );
  }
}
