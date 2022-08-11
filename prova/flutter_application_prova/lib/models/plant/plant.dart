import 'dart:io';

import 'package:flutter/material.dart';

//TODO: Aggiungere o tutti o alcuni pid, display_pid, alias, min_light_mmol, max_light_mmol, min_light_lux, max_light_lux, min_temp, max_temp,
//TODO: Aggiungere min_env_humid, max_env_humid, min_soil_moist, max_soil_moist, min_soil_ec, max_soil_ec, image_url

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
  final File img;
  final String? img_path;

  Plant({required this.name, required this.family, required this.waterAmount, required this.sunAmount, 
  required this.description, required this.otherDescription, required this.plantAccuracy, required this.img, this.img_path});
}