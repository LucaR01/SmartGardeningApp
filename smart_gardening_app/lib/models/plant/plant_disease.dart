import 'dart:ffi';

import 'package:flutter/material.dart';

class PlantDisease {
  final String name; //TODO: should be a list in case there are more diseases.
  final String description; //TODO: should be a list in case there are more diseases.
  final String solutions; //TODO: should be a list in case there are more diseases.
  final Float diseaseAccuracy; //TODO: float o double //TODO: should be a list in case there are more diseases.

  PlantDisease({required this.name, required this.description, required this.solutions, required this.diseaseAccuracy});
}