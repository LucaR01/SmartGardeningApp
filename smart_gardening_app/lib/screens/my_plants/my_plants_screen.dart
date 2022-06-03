import 'package:flutter/material.dart';

import '../../widgets/app_bar/app_bar.dart';

class MyPlantsScreen extends StatefulWidget {
  const MyPlantsScreen({Key? key}) : super(key: key);

  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO:
      appBar: AppBarWidget(),
    );
  }
}