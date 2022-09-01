import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/plant_api/plant_api.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({ Key? key }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle( //TODO: ThreeBounce?
          color: Colors.green[900],
          size: 90.0,
        ),
      ),
    );
  }
}