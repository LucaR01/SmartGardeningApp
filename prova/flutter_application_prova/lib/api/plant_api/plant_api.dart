import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'dart:convert';
//import 'package:oauth2/oauth2.dart'; //TODO: remove
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';

//TODO: aggiungere nel manifest di android per far funzionare il package oauth2_client e cambiare il PodFile di iOS

class PlantBookOAuth2Client extends OAuth2Client { 
  PlantBookOAuth2Client({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: 'https://open.plantbook.io/', tokenUrl: 'https://open.plantbook.io/api/v1/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) { //TODO: aggiungere authorizeUrl e tokenUrl
    //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO: uncomment
  } //TODO: token/name='token'; https://open.plantbook.io/social-auth/
}

class PlantAPI {

  static const String clientId = ''; //TODO: 
  static const String clientSecret = ''; //TODO:

  //TODO: remove
  static void getData() async {

    //TODO: Uri.parse() per convertire un url a Uri
    //Uri site = Uri.parse('open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    //print('site: ${site}');

    Response response = await get(Uri.https('open.plantbook.io', '/api/v1/plant/detail/jasminum%20floridum/?format=json')); //TODO: jsonplaceholder api for testing
    Response response2 = await get(Uri.https('open.plantbook.io', '/api/v1/plant/detail/jasminum%20floridum/?format=json'));
    //List<dynamic> data = jsonDecode(response.body);
    //print(data);
    //print(data['title']); //TODO: remove
    print(response.body);
    print('RESPONSE2: ${response2.body}');

    /*for (var u in data) {
      print('${u['email']}, ${u['name']}, ${u['username']}');
    }*/

    //TODO: passare il pid o alias per ottenere l'informazione sulla pianta
    //TODO: https://open.plantbook.io/api/v1/plant/search?alias=acanthus%20ilicifolius
    //TODO: api/v1/plant/detail/ /?format=json
  }

  //Response r = await get(Uri.parse('https://api.somewhere.io'), headers: <String, String>{'authorization': basicAuth}); //TODO: update
  //print(r.statusCode);
  //print(r.body);

  //TODO: static?
  OAuth2Client client = PlantBookOAuth2Client(redirectUri: 'https://open.plantbook.io', customUriScheme: 'api/v1/plant/detail/jasminum%20floridum/?format=json'); //TODO: aggiungere redirect e customUri

  //TODO: rename in getData
  void getData2({required String clientId, required String clientSecret}) async {
    //AccessTokenResponse tokenResponse = await client.getTokenWithAuthCodeFlow(clientId: '', clientSecret: '', scopes: ['']); //TODO: 
    AccessTokenResponse tokenResponse = await client.getTokenWithClientCredentialsFlow(clientId: '', clientSecret: '', scopes: ['https://www.open.plantbook.io/']); //TODO: 

    if (tokenResponse.isExpired()) {
      tokenResponse = await client.refreshToken(tokenResponse.refreshToken!, clientId: clientId);
    }

    Response response = await get(Uri.https('', ''), headers: {'Authorization': 'Bearer' + tokenResponse.accessToken!}); //TODO: 
  }

  static void getData3() async {
    OAuth2Client client = PlantBookOAuth2Client(redirectUri: '', customUriScheme: 'open.plantbook.io'); //redirectUri: open.plantbook.io:/api/v1/plant/detail/jasminum%20floridum/?format=json

    OAuth2Helper oauth2Helper = OAuth2Helper(client, grantType: OAuth2Helper.AUTHORIZATION_CODE, clientId: clientId, clientSecret: clientSecret, scopes: ['https://open.plantbook.io/api/v1/']); //TODO: https://open.plantbook.io

    Response response = await oauth2Helper.get('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    print(response.body);
  }

}