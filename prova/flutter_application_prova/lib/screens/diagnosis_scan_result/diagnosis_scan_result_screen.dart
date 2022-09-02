import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/plant/plant_disease.dart';

class DiagnosisScanResultScreen extends StatefulWidget {
  const DiagnosisScanResultScreen({ Key? key, required this.plantDisease}) : super(key: key);

  final PlantDisease plantDisease;

  @override
  State<DiagnosisScanResultScreen> createState() => _DiagnosisScanResultScreenState();
}

class _DiagnosisScanResultScreenState extends State<DiagnosisScanResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}