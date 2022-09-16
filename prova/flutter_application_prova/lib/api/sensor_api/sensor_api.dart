import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/aircare_sensor/aircare_sensor.dart';
import 'package:flutter_application_prova/models/aircare_sensor/health_index.dart';
import 'package:flutter_application_prova/models/shared_preferences/user_preferences.dart';
import 'package:http/http.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

//TODO: volendo si può salvare la stringa dell'access token nelle shared preferences
//TODO: volendo spostare tutte le costanti stringhe nel file string_constants

class SensorAPI {

  static const String clientId = ''; //TODO: 
  static const String clientSecret = ''; //TODO: 

  static const String email = ''; //TODO: 
  static const String password = ''; //TODO: 

  static const String grantTypePassword = 'password';
  static const String grantTypeRefreshToken = 'refresh_token';

  static const String scope = 'read_homecoach';

  static const String method = 'POST';
  static const String charset = 'UTF-8';

  static const String acceptJson = 'application/json';
  static const String contentType = 'application/x-www-form-urlencoded';

  static const String tokenUrl = 'https://api.netatmo.com/oauth2/token';
  static const String apiUrl = 'https://api.netatmo.com/api';
  static const String getHomeCoachsDataUrl = '/gethomecoachsdata?device_id=';

  static const int statusSuccess = 200;

  static Future<AccessTokenResponse?> _getAccessTokenResponse() async {
    var headers = {
    'Accept-Charset': charset,
    'Content-Type': contentType
    };

    var request = Request(method, Uri.parse(tokenUrl)); 
    request.bodyFields = { 
      'grant_type': grantTypePassword,
      'client_id': clientId,
      'client_secret': clientSecret,
      'username': email,
      'password': password,
      'scope': scope
    };

    request.headers.addAll(headers);

    Response response = await Response.fromStream(await request.send());

    if (response.statusCode == SensorAPI.statusSuccess) {
      AccessTokenResponse tokenResponse = AccessTokenResponse.fromHttpResponse(response);

      //TODO: remove prints
      print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
      print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
      print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
      print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
      print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
      print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
      print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');

      //TODO: UserPreferences.setNetatmotAPIToken(tokenResponse.accessToken!); questo non basta per poter creare un AccessTokenResponse
      //TODO: List<String>
      //TODO: Set<dynamic> list = {tokenResponse.accessToken!, tokenResponse.expiresIn!, tokenResponse.scope!, tokenResponse.expiresIn!, tokenResponse.refreshToken, tokenResponse.tokenType};

      return tokenResponse;
    }

    return null;
  }

  static Future<AirCareSensor?> getAirCareSensorData({required String deviceId}) async {

    AccessTokenResponse? tokenResponse = await _getAccessTokenResponse(); //TODO: recuperarlo dalle SharedPreferences prima di chiamare _getAccessTokenResponse();
    //TODO: AccessTokenResponse tokenResponse = UserPreferences.getNetatmoAPIAccessToken() ?? await _getAccessTokenResponse();

    if(tokenResponse == null) {
      print('Error: AccessToken is null!');
    } else {

      if(tokenResponse.isExpired()) {
        var headers = {
          'Accept-Charset': charset,
          'Content-Type': contentType
        };

        var refreshTokenRequest = Request(method, Uri.parse(tokenUrl));

        refreshTokenRequest.bodyFields = {
          'grant_type': grantTypeRefreshToken,
          'refresh_token': tokenResponse.refreshToken!,
          'client_id': clientId,
          'client_secret': clientSecret
        };

        refreshTokenRequest.headers.addAll(headers);

        Response response = await Response.fromStream(await refreshTokenRequest.send());
        tokenResponse = AccessTokenResponse.fromHttpResponse(response);
      }
    }

    var headers = {
    'Accept': acceptJson,
    'Authorization': 'Bearer ${tokenResponse!.accessToken}' 
    };

    var AirCareSensorDataRequest = Request(method, Uri.parse('$apiUrl$getHomeCoachsDataUrl$deviceId'));
    AirCareSensorDataRequest.headers.addAll(headers);

    StreamedResponse response = await AirCareSensorDataRequest.send();

    if (response.statusCode == SensorAPI.statusSuccess) {

      String airCareSensorData = await response.stream.bytesToString();
      print('airCareSensorData: $airCareSensorData'); //TODO: remove
      Map<String, dynamic> decodedAirCareSensorData = jsonDecode(airCareSensorData);
      print('decodedAirCareSensorData: $decodedAirCareSensorData'); //TODO: remove

      var dashBoardData = decodedAirCareSensorData["body"]["devices"][0]["dashboard_data"];
      print('dashBoardData: ${dashBoardData}'); //TODO: remove

      return AirCareSensor(timeUtc: dashBoardData['time_utc'], temperature: dashBoardData['Temperature'], co2: dashBoardData['CO2'], humidity: dashBoardData['Humidity'], noise: dashBoardData['Noise'], pressure: dashBoardData['Pressure'], absolutePressure: dashBoardData['AbsolutePressure'], healthIndex: HealthIndex.values[dashBoardData['health_idx']], minTemp: dashBoardData['min_temp'], maxTemp: dashBoardData['max_temp'], dateMaxTemp: dashBoardData['date_max_temp'], dateMinTemp: dashBoardData['date_min_temp']);
    }
    else {
      print(response.reasonPhrase);
    }

    return null;
  }

}