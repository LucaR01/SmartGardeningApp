import 'dart:io';

import 'package:flutter/material.dart';

class Plant {
  final String pid;
  final String displayPid;
  final String alias;
  final int maxLightMmol; 
  final int minLightMmol; 
  final int maxLightLux;
  final int minLightLux;
  final int maxTemp;
  final int minTemp;
  final int maxEnvHumid;
  final int minEnvHumid;
  final int maxSoilMoist;
  final int minSoilMoist;
  final int maxSoilEC;
  final int minSoilEC;
  final String imageUrl; //TODO: String? o File o File?
  final double accuracy;

  Plant({required this.pid, required this.displayPid, required this.alias, 
  required this.maxLightMmol, required this.minLightMmol, required this.maxLightLux, required this.minLightLux, 
  required this.maxTemp, required this.minTemp, required this.maxEnvHumid, required this.minEnvHumid, 
  required this.maxSoilMoist, required this.minSoilMoist, 
  required this.maxSoilEC, required this.minSoilEC, required this.imageUrl, required this.accuracy});
}