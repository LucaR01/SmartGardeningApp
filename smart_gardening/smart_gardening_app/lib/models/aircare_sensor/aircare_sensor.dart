import 'package:smart_gardening_app/models/aircare_sensor/health_index.dart';

/// It represents an Netatmo Home Care Sensor
class AirCareSensor {
  final dynamic timeUtc;
  final dynamic temperature;
  final dynamic co2;
  final dynamic humidity;
  final dynamic noise;
  final dynamic pressure;
  final dynamic absolutePressure;
  final HealthIndex healthIndex;
  final dynamic minTemp;
  final dynamic maxTemp;
  final dynamic dateMaxTemp;
  final dynamic dateMinTemp;

  AirCareSensor({required this.timeUtc, required this.temperature, required this.co2, required this.humidity, required this.noise, 
  required this.pressure, required this.absolutePressure, required this.healthIndex, required this.minTemp, required this.maxTemp, 
  required this.dateMaxTemp, required this.dateMinTemp});

  /// It creates an [AirCareSensor] from the json passed in.
  factory AirCareSensor.fromJson(Map<String, dynamic> json) => AirCareSensor(
    timeUtc: json["time_utc"],
    temperature: json["Temperature"],
    co2: json["CO2"],
    humidity: json["Humidity"],
    noise: json["Noise"],
    pressure: json["Pressure"],
    absolutePressure: json["AbsolutePressure"], // questo potrebbe non andare perché è un int e non un enum.
    healthIndex: json["health_idx"],
    minTemp: json["min_temp"],
    maxTemp: json["max_temp"],
    dateMaxTemp: json["date_max_temp"],
    dateMinTemp: json["date_min_temp"]
  );
}