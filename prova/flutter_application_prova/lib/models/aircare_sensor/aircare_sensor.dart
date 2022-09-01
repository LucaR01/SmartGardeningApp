import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/aircare_sensor/health_index.dart';

class AirCareSensor {
  final String timeUtc;
  final double temperature;
  final int co2;
  final int humidity;
  final int noise;
  final int pressure;
  final double absolutePressure;
  //final int healthIdx; //TODO: remove
  final HealthIndex healthIdx;
  final double minTemp;
  final double maxTemp;
  final int dateMaxTemp;
  final int dateMinTemp;

  AirCareSensor({required this.timeUtc, required this.temperature, required this.co2, required this.humidity, required this.noise, 
  required this.pressure, required this.absolutePressure, required this.healthIdx, required this.minTemp, required this.maxTemp, 
  required this.dateMaxTemp, required this.dateMinTemp});
}