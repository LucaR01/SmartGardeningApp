import 'dart:ffi';

import 'package:flutter/material.dart';

class Plant {
  final String name;
  final String family;
  //TODO: final String species;
  //TODO: final String reign;
  //TODO: final String class;
  //TODO: final String order;
  final int waterAmount;
  final int sunAmount;
  final String description;
  final String otherDescription;
  final double plantAccuracy; //TODO: float or Float

  Plant({required this.name, required this.family, required this.waterAmount, required this.sunAmount, 
  required this.description, required this.otherDescription, required this.plantAccuracy});
}