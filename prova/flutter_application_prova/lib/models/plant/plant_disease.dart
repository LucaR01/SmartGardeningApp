import 'dart:ffi';

import 'package:flutter/material.dart';

//TODO: rename in SickPlant?
class PlantDisease {
  final String name; //TODO: should be a list in case there are more diseases.
  final String description; //TODO: should be a list in case there are more diseases.
  final String solutions; //TODO: should be a list in case there are more diseases.
  final Float diseaseAccuracy; //TODO: float o double //TODO: should be a list in case there are more diseases.
  final String img; //TODO: forse non serve?

  PlantDisease({required this.name, required this.description, required this.solutions, required this.diseaseAccuracy, required this.img});
}