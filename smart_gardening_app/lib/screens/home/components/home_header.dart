import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green[100], //TODO: remove
      drawer: const Drawer(), // È il menù.
      appBar: AppBar(
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
      ),

    );
  }
}