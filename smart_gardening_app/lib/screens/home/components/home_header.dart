import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green, 
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text("Smart Gardening App"),
      ),
    );
  }
}