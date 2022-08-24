import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';

import 'package:http/http.dart';
import 'package:oauth2_client/interfaces.dart';
import 'dart:convert';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import 'dart:developer'; //TODO: remove ; per inspect()

//TODO: cambiare il PodFile di iOS
//TODO: WWW-Authenticate: Bearer realm="api"
//TODO: Salvare il token nelle SharedPreferences?

//TODO: credo perché fa un host failed lookup perché cerca www.open.plantbook.io al posto di open.plantbook.io (nella maggior parte di questi)

//TODO: volendo al posto di 'noauth' si può mettere ''
class PlantBookOAuth2Client extends OAuth2Client { 
  PlantBookOAuth2Client({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: 'noauth', tokenUrl: 'https://open.plantbook.io/api/v1/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) {
    //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO: uncomment/remove
  }
}

class PlantAPI {

  static const String clientId = ''; //TODO: 
  static const String clientSecret = ''; //TODO:

  static final OAuth2Client _client = PlantBookOAuth2Client(redirectUri: '', customUriScheme: 'open.plantbook.io');

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

      /*Plant p = Plant(pid: decodedPlantDetails['pid'], displayPid: decodedPlantDetails['display_pid'], alias: decodedPlantDetails['alias'], maxLightMmol: decodedPlantDetails['max_light_mmol'], minLightMmol: decodedPlantDetails['min_light_mmol'], maxLightLux: decodedPlantDetails['max_light_lux'], minLightLux: decodedPlantDetails['min_light_lux'], 
      maxTemp: decodedPlantDetails['max_temp'], minTemp: decodedPlantDetails['min_temp'], maxEnvHumid: decodedPlantDetails['max_env_humid'], 
      minEnvHumid: decodedPlantDetails['min_env_humid'], maxSoilMoist: decodedPlantDetails['max_soil_moist'], minSoilMoist: decodedPlantDetails['min_soil_moist'], 
      maxSoilEC: decodedPlantDetails['max_soil_ec'], minSoilEC: decodedPlantDetails['min_soil_ec'], imageUrl: decodedPlantDetails['image_url'], accuracy: accuracy); //TODO: remove

      inspect(p); //TODO: remove ; insect serve per mostrare tutti i campi della classe che si vuole ispezionare */

      return Plant(pid: decodedPlantDetails['pid'], displayPid: decodedPlantDetails['display_pid'], alias: decodedPlantDetails['alias'], maxLightMmol: decodedPlantDetails['max_light_mmol'], minLightMmol: decodedPlantDetails['min_light_mmol'], maxLightLux: decodedPlantDetails['max_light_lux'], minLightLux: decodedPlantDetails['min_light_lux'], 
      maxTemp: decodedPlantDetails['max_temp'], minTemp: decodedPlantDetails['min_temp'], maxEnvHumid: decodedPlantDetails['max_env_humid'], 
      minEnvHumid: decodedPlantDetails['min_env_humid'], maxSoilMoist: decodedPlantDetails['max_soil_moist'], minSoilMoist: decodedPlantDetails['min_soil_moist'], 
      maxSoilEC: decodedPlantDetails['max_soil_ec'], minSoilEC: decodedPlantDetails['min_soil_ec'], imageUrl: decodedPlantDetails['image_url'], accuracy: accuracy);

    } catch(e) {
      return null;
    } /*finally { //TODO: remove
      return null;
    }*/
  }

}