import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/aircare_sensor/health_index.dart';

class AirCareSensor {
  final int timeUtc;
  final double temperature;
  final int co2;
  final int humidity;
  final int noise;
  final double pressure;
  final double absolutePressure;
  final HealthIndex healthIndex;
  final int minTemp;
  final double maxTemp;
  final int dateMaxTemp;
  final int dateMinTemp;

  AirCareSensor({required this.timeUtc, required this.temperature, required this.co2, required this.humidity, required this.noise, 
  required this.pressure, required this.absolutePressure, required this.healthIndex, required this.minTemp, required this.maxTemp, 
  required this.dateMaxTemp, required this.dateMinTemp});

  factory AirCareSensor.fromJson(Map<String, dynamic> json) => AirCareSensor(
    timeUtc: json["time_utc"],
    temperature: json["Temperature"],
    co2: json["CO2"],
    humidity: json["Humidity"],
    noise: json["Noise"],
    pressure: json["Pressure"],
    absolutePressure: json["AbsolutePressure"], //TODO: questo potrebbe non andare perché è un int e non un enum.
    healthIndex: json["health_idx"],
    minTemp: json["min_temp"],
    maxTemp: json["max_temp"],
    dateMaxTemp: json["date_max_temp"],
    dateMinTemp: json["date_min_temp"]
  );
}