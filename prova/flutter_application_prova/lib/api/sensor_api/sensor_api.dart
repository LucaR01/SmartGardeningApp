import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/aircare_sensor/aircare_sensor.dart';
import 'package:flutter_application_prova/models/aircare_sensor/health_index.dart';
import 'package:http/http.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';

class SensorOAuth2Client extends OAuth2Client {
  SensorOAuth2Client({required String redirectUri, required String customUriScheme})
    : super(authorizeUrl: '', tokenUrl: 'https://api.netatmo.com/oauth2/token', redirectUri: redirectUri, customUriScheme: customUriScheme) {
      //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO:
  }
}

//TODO: /gethomecoachsdata; scopes: ['read_homecoach'];

class SensorAPI {

  static const String clientId = ''; //TODO: 
  static const String clientSecret = ''; //TODO: 

  static const String email = ''; //TODO: 
  static const String password = ''; //TODO: 
 
  static final OAuth2Client _client = SensorOAuth2Client(redirectUri: '', customUriScheme: 'open.plantbook.io'); //TODO:

  static Future<AirCareSensor?> getData() async {
    try {
      AccessTokenResponse tokenResponse = await _client.getTokenWithClientCredentialsFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['read_homecoach']); //TODO: , httpClient: [email, password]

      if(tokenResponse.isExpired()) {
        print('Token has expired'); //TODO: remove
        tokenResponse = await _client.refreshToken(tokenResponse.refreshToken!, clientId: clientId, clientSecret: clientSecret);
        print('Token has been refreshed'); //TODO: remove
      }

      //TODO: remove prints
      print('client: ${_client.toString()}');
      print('oauth2Helper: ${tokenResponse}');
      print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
      print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
      print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
      print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
      print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
      print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
      print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');
      print('oauth2Helper.toString(): ${tokenResponse.toString()}');

      Response response = await get(Uri.https('api.netatmo.com', ''), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!}); //TODO: authorize?grant_type=password&client_id=[YOUR_APP_ID]&client_secret=[YOUR_CLIENT_SECRET]&username=[USER_MAIL]&password=[USER_PASSWORD]&scope=[SCOPES_SPACE_SEPARATED]
      //dynamic decodedAircareSensor = jsonDecode(response.body); //TODO: uncomment
      print('response.body: ${response.body}'); //TODO: remove

      //TODO: remove
      print('HealthIndex.fine.index: ${HealthIndex.fine.index}');
      print('HealthIndex.values[1]: ${HealthIndex.values[1]}');

      //TODO: decodedAircareSensor['time_utc'] Temperature, CO2, Humidity, Noise, Pressure, AbsolutePressure, Health.values[decodedAircareSensor['health_idx']], min_temp, max_temp, date_max_temp, date_min_temp
      return AirCareSensor(timeUtc: '', temperature: 21.2, co2: 967, humidity: 37, noise: 41, pressure: 45, absolutePressure: 1022.9, healthIdx: HealthIndex.values[1], minTemp: 21.2, maxTemp: 27.4, dateMaxTemp: 1555662436, dateMinTemp: 1555631374); //TODO: 
    } catch(e)  {
      print('Error: ${e}');
      return null;
    }
  }
}