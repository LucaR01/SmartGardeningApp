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
  final HealthIndex healthIndex;
  final double minTemp;
  final double maxTemp;
  final String dateMaxTemp;
  final String dateMinTemp;

  AirCareSensor({required this.timeUtc, required this.temperature, required this.co2, required this.humidity, required this.noise, 
  required this.pressure, required this.absolutePressure, required this.healthIndex, required this.minTemp, required this.maxTemp, 
  required this.dateMaxTemp, required this.dateMinTemp});
}