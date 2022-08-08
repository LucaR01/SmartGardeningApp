import 'package:flutter/material.dart';

class FlashErrorScreen extends StatelessWidget {
  const FlashErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          }, 
          child: const Text("Show Message"),
        ),
      ),
    );
  }
}