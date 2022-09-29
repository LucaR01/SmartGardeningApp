import 'package:flutter_application_prova/models/plant/plant.dart';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/access_token_response.dart';

import 'dart:developer'; //per inspect()

//TODO: Salvare il token nelle SharedPreferences?

//volendo al posto di 'noauth' si può mettere ''
/// It creates a custom type of client that extends [OAuth2Client] and pass the [authorizeUrl] and the [tokenUrl] of the API.
class PlantBookOAuth2Client extends OAuth2Client { 
  PlantBookOAuth2Client({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: 'noauth', tokenUrl: 'https://open.plantbook.io/api/v1/token/', redirectUri: redirectUri, customUriScheme: customUriScheme);
}

class PlantAPI {

  static const String clientId = ''; //TODO: 
  static const String clientSecret = ''; //TODO:

  static final OAuth2Client _client = PlantBookOAuth2Client(redirectUri: '', customUriScheme: 'open.plantbook.io');

  /// Returns a [Plant] if it has been retrieved from the API, otherwise it returns null.
  /// It creates an [AccessTokenResponse] to get access to the API after passing [clientId], [clientSecret] and the scopes, if it is valid, 
  /// it sends a [Response] with the Authorization Bearer and the [tokenResponse] to get the json data
  /// After it has been decoded from json it saves and returns a [Plant] or a null value.
  /// ```dart
  /// Plant p = await SensorAPI.getData('jasminum floridum', 0.98);
  /// ```
  static Future<Plant?> getData({required String plantPID, required double accuracy}) async {
    try {
      AccessTokenResponse tokenResponse = await _client.getTokenWithClientCredentialsFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['read']);

      if(tokenResponse.isExpired()) {
        print('Token has expired'); //TODO: remove
        tokenResponse = await _client.refreshToken(tokenResponse.refreshToken!, clientId: clientId);
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

      Response response = await get(Uri.https('open.plantbook.io', '/api/v1/plant/detail/${plantPID}'), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!});
      dynamic decodedPlantDetails = jsonDecode(response.body);

      return Plant(pid: decodedPlantDetails['pid'], displayPid: decodedPlantDetails['display_pid'], alias: decodedPlantDetails['alias'], maxLightMmol: decodedPlantDetails['max_light_mmol'], minLightMmol: decodedPlantDetails['min_light_mmol'], maxLightLux: decodedPlantDetails['max_light_lux'], minLightLux: decodedPlantDetails['min_light_lux'], 
      maxTemp: decodedPlantDetails['max_temp'], minTemp: decodedPlantDetails['min_temp'], maxEnvHumid: decodedPlantDetails['max_env_humid'], 
      minEnvHumid: decodedPlantDetails['min_env_humid'], maxSoilMoist: decodedPlantDetails['max_soil_moist'], minSoilMoist: decodedPlantDetails['min_soil_moist'], 
      maxSoilEC: decodedPlantDetails['max_soil_ec'], minSoilEC: decodedPlantDetails['min_soil_ec'], imageUrl: decodedPlantDetails['image_url'], accuracy: accuracy);

    } catch(e) {
      return null;
    }
  }

}