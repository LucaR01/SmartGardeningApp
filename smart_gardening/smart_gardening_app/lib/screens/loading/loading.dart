import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

//TODO: remove?

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

  /*@override //TODO: uncomment
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: Colors.green[900],
      size: 90.0,
    );
  }*/
}