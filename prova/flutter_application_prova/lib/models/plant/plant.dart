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

  factory Plant.fromMap(Map<String, dynamic> json) => new Plant(
    pid: json['pid'],
    displayPid: json['display_pid'],
    alias: json['alias'],
    maxLightMmol: json['max_light_mmol'],
    minLightMmol: json['min_light_mmol'],
    maxLightLux: json['max_light_lux'],
    minLightLux: json['min_light_lux'],
    maxTemp: json['max_temp'],
    minTemp: json['min_temp'],
    maxEnvHumid: json['max_env_humid'],
    minEnvHumid: json['min_env_humid'],
    maxSoilMoist: json['max_soil_moist'],
    minSoilMoist: json['min_soil_moist'],
    maxSoilEC: json['max_soil_EC'],
    minSoilEC: json['min_soil_EC'],
    imageUrl: json['image_url'],
    accuracy: json['accuracy'],
  );

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'display_pid': displayPid,
      'alias': alias,
      'max_light_mmol': maxLightMmol,
      'min_light_mmol': minLightMmol,
      'max_light_lux': maxLightLux,
      'min_light_lux': minLightLux,
      'max_temp': maxTemp,
      'min_temp': minTemp,
      'max_env_humid': maxEnvHumid,
      'min_env_humid': minEnvHumid,
      'max_soil_moist': maxSoilMoist,
      'min_soil_moist': minSoilMoist,
      'max_soil_EC': maxSoilEC,
      'min_soil_EC': minSoilEC,
      'image_url': imageUrl,
      'accuracy': accuracy,
    };
  }
}