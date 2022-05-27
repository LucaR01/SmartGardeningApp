import 'package:flutter/material.dart';

import 'components/body.dart';

//TODO: rinominare la cartella 'screens' in 'pages'?

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
