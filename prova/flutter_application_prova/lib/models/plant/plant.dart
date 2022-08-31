import 'dart:io';

import 'package:flutter/material.dart';

class Plant {
  final int? id; //TODO: potrei forse rimuoverlo?
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

  Plant({this.id, required this.pid, required this.displayPid, required this.alias, 
  required this.maxLightMmol, required this.minLightMmol, required this.maxLightLux, required this.minLightLux, 
  required this.maxTemp, required this.minTemp, required this.maxEnvHumid, required this.minEnvHumid, 
  required this.maxSoilMoist, required this.minSoilMoist, 
  required this.maxSoilEC, required this.minSoilEC, required this.imageUrl, required this.accuracy});

  factory Plant.fromMap(Map<String, dynamic> json) => new Plant(
    //id: json['id'], //TODO: remove?
    pid: json['pid'],
    displayPid: json['displayPid'],
    alias: json['alias'],
    maxLightMmol: json['maxLightMmol'],
    minLightMmol: json['minLightMmol'],
    maxLightLux: json['maxLightLux'],
    minLightLux: json['minLightLux'],
    maxTemp: json['maxTemp'],
    minTemp: json['minTemp'],
    maxEnvHumid: json['maxEnvHumid'],
    minEnvHumid: json['minEnvHumid'],
    maxSoilMoist: json['maxSoilMoist'],
    minSoilMoist: json['minSoilMoist'],
    maxSoilEC: json['maxSoilEC'],
    minSoilEC: json['minSoilEC'],
    imageUrl: json['imageUrl'],
    accuracy: json['accuracy']
  );

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'pid': pid,
      'displayPid': displayPid,
      'alias': alias,
      'maxLightMmol': maxLightMmol,
      'minLightMmol': minLightMmol,
      'maxLightLux': maxLightLux,
      'minLightLux': minLightLux,
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'maxEnvHumid': maxEnvHumid,
      'minEnvHumid': minEnvHumid,
      'maxSoilMoist': maxSoilMoist,
      'minSoilMoist': minSoilMoist,
      'maxSoilEC': maxSoilEC,
      'minSoilEC': minSoilEC,
      'imageUrl': imageUrl,
      'accuracy': accuracy
    };

    map.removeWhere((key, value) => value == null);

    return map;

    /*return {
      'pid': pid,
      'displayPid': displayPid,
      'alias': alias,
      'maxLightMmol': maxLightMmol,
      'minLightMmol': minLightMmol,
      'maxLightLux': maxLightLux,
      'minLightLux': minLightLux,
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'maxEnvHumid': maxEnvHumid,
      'minEnvHumid': minEnvHumid,
      'maxSoilMoist': maxSoilMoist,
      'minSoilMoist': minSoilMoist,
      'maxSoilEC': maxSoilEC,
      'minSoilEC': minSoilEC,
      'imageUrl': imageUrl,
      'accuracy': accuracy
    };*/
  }
}