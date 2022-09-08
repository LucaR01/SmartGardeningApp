import 'dart:ffi';

import 'package:flutter/material.dart';

//TODO: rename in SickPlant?
class PlantDisease {
  final String name; //TODO: should be a list in case there are more diseases.
  final double diseaseConfidence; //TODO: float o double //TODO: should be a list in case there are more diseases.

  PlantDisease({required this.name, required this.diseaseConfidence});
}