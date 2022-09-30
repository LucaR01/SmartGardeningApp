import 'package:smart_gardening_app/constants/constants.dart';
import 'package:smart_gardening_app/models/aircare_sensor/aircare_sensor.dart';
import 'package:smart_gardening_app/models/aircare_sensor/health_index.dart';
import 'package:http/http.dart';
import 'package:oauth2_client/access_token_response.dart';

import 'dart:convert';
import 'dart:developer';

//TODO: volendo si può salvare la stringa dell'access token nelle shared preferences

class SensorAPI {

  // Queste costanti le lascio qui, al posto di metterle in constants perché è più comodo averle qui.
  static const String clientId = ''; //TODO: 
  static const String clientSecret = ''; //TODO: 

  static const String email = ''; //TODO: 
  static const String password = ''; //TODO: 

  /// It sends a [Request] to the API by passing the grant type, [clientId], [clientSecret], [email] (username), [password] and [Constants.sensorAPIScope]
  /// and returns either an [AccessTokenResponse] or a null value.
  static Future<AccessTokenResponse?> _getAccessTokenResponse() async {
    var headers = {
    'Accept-Charset': Constants.sensorAPICharset,
    'Content-Type': Constants.sensorAPIContentType
    };

    var request = Request(Constants.sensorAPIMethod, Uri.parse(Constants.sensorAPITokenUrl)); 
    request.bodyFields = { 
      'grant_type': Constants.sensorAPIGrantTypePassword,
      'client_id': clientId,
      'client_secret': clientSecret,
      'username': email,
      'password': password,
      'scope': Constants.sensorAPIScope
    };

    request.headers.addAll(headers);

    Response response = await Response.fromStream(await request.send());

    if (response.statusCode == Constants.statusSuccess) {
      AccessTokenResponse tokenResponse = AccessTokenResponse.fromHttpResponse(response);

      //TODO: remove prints
      print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
      print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
      print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
      print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
      print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
      print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
      print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');

      return tokenResponse;
    }

    return null;
  }

  /// It sends a [Request] to the API if it has been able to retrieve the [AccessTokenResponse]
  /// and if the [deviceId] is valid, it retrieves the data and returns a [AirCareSensor]
  /// otherwise it returns null.
  static Future<AirCareSensor?> getAirCareSensorData({required String deviceId}) async {

    AccessTokenResponse? tokenResponse = await _getAccessTokenResponse(); //TODO: recuperarlo dalle SharedPreferences prima di chiamare _getAccessTokenResponse();
    //TODO: AccessTokenResponse tokenResponse = UserPreferences.getNetatmoAPIAccessToken() ?? await _getAccessTokenResponse();

    if(tokenResponse == null) {
      print('Error: AccessToken is null!');
    } else {

      if(tokenResponse.isExpired()) {
        var headers = {
          'Accept-Charset': Constants.sensorAPICharset,
          'Content-Type': Constants.sensorAPIContentType
        };

        var refreshTokenRequest = Request(Constants.sensorAPIMethod, Uri.parse(Constants.sensorAPITokenUrl));

        refreshTokenRequest.bodyFields = {
          'grant_type': Constants.sensorAPIGrantTypeRefreshToken,
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
    'Accept': Constants.sensorAPIAcceptJson,
    'Authorization': 'Bearer ${tokenResponse!.accessToken}' 
    };

    var airCareSensorDataRequest = Request(Constants.sensorAPIMethod, Uri.parse('${Constants.sensorAPIApiUrl}${Constants.sensorAPIGetHomeCoachsDataUrl}$deviceId'));
    airCareSensorDataRequest.headers.addAll(headers);

    StreamedResponse response = await airCareSensorDataRequest.send();

    if (response.statusCode == Constants.statusSuccess) {

      String airCareSensorData = await response.stream.bytesToString();
      print('airCareSensorData: $airCareSensorData'); //TODO: remove
      Map<String, dynamic> decodedAirCareSensorData = jsonDecode(airCareSensorData);
      print('decodedAirCareSensorData: $decodedAirCareSensorData'); //TODO: remove

      var dashBoardData = decodedAirCareSensorData["body"]["devices"][0]["dashboard_data"];
      print('dashBoardData: $dashBoardData'); //TODO: remove

      return AirCareSensor(timeUtc: dashBoardData['time_utc'], temperature: dashBoardData['Temperature'], co2: dashBoardData['CO2'], humidity: dashBoardData['Humidity'], noise: dashBoardData['Noise'], pressure: dashBoardData['Pressure'], absolutePressure: dashBoardData['AbsolutePressure'], healthIndex: HealthIndex.values[dashBoardData['health_idx']], minTemp: dashBoardData['min_temp'], maxTemp: dashBoardData['max_temp'], dateMaxTemp: dashBoardData['date_max_temp'], dateMinTemp: dashBoardData['date_min_temp']);
    }
    else {
      print(response.reasonPhrase);
    }

    return null;
  }

}