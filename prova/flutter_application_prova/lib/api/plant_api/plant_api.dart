import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:oauth2_client/interfaces.dart';
import 'dart:convert';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';

//TODO: cambiare il PodFile di iOS
//TODO: Bearer realm="api"
//TODO: Salvare il token nelle SharedPreferences?

//TODO: getData2/4/8/9/13 non funzionano e credo perché fa un host failed lookup perché cerca www.open.plantbook.io al posto di open.plantbook.io (nella maggior parte di questi)
//TODO: il resto dei getData funziona.
//TODO: PlantBookOAuth2Client da utilizzare sono il 5 e il 6.

class PlantBookOAuth2Client extends OAuth2Client { 
  PlantBookOAuth2Client({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: 'noauth', tokenUrl: 'https://open.plantbook.io/api/v1/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) {
    //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO: uncomment
  } //TODO: token/name='token'; https://open.plantbook.io/social-auth/
}

class PlantAPI {

  static const String clientId = ''; //TODO: 
  static const String clientSecret = ''; //TODO:

  static void getData() async {
    print('============================= GET DATA ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client(redirectUri: 'open.plantbook.io:/open.plantbook.io/login/?next=/browse-db/?contain=jasminum+floridum', customUriScheme: 'open.plantbook.io');

    AccessTokenResponse tokenResponse = await client.getTokenWithClientCredentialsFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['read']); //TODO: read:plant?

    if(tokenResponse.isExpired()) {
      tokenResponse = await client.refreshToken(tokenResponse.refreshToken!, clientId: clientId);
    }

    //TODO: remove prints
    print('client: ${client.toString()}');
    print('oauth2Helper: ${tokenResponse}');
    print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
    print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
    print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
    print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
    print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
    print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
    print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');
    print('oauth2Helper.toString(): ${tokenResponse.toString()}');

    //TODO: WWW-Authenticate: Bearer realm="api"

    /*Response r = await get(Uri.parse('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json'), headers: <String, String>{'Authorization': 'Bearer' + tokenResponse.accessToken!}); //TODO: update
    print(r.body);
    print('jsonDecode(r.body): ${jsonDecode(r.body)}');
    print(r.statusCode);*/

    //TODO: Django rest api

    Response r2 = await get(Uri.https('open.plantbook.io', '/api/v1/plant/detail/jasminum%20floridum/?format=json'), headers: <String, String>{'Authorization': 'Bearer' + tokenResponse.accessToken!}); //TODO: WWW-Authenticate: Bearer realm="api"
    //print(r2.body);
    var decode = jsonDecode(r2.body);
    print('jsonDecode(r2.body): ${decode}');
    //print(r2.statusCode);

    var field = tokenResponse.getRespField('pid'); //TODO: search?
    print('field: ${field}');
    print('field2: ${tokenResponse.getRespField("search='rose'")}');
    print('field3: ${tokenResponse.getRespField('plant')}');
    print('field4: ${tokenResponse.getRespField('detail')}');
    print('field5: ${tokenResponse.getRespField('plant/detail')}');
    print('field6: ${tokenResponse.getRespField('/plant/detail')}');
    print('field7: ${tokenResponse.getRespField('api/v1/plant/search')}');
    print('field8: ${tokenResponse.getRespField('/api/v1/plant/search')}');
    print('field9: ${tokenResponse.getRespField('api-details')}');
    print('field10: ${tokenResponse.getRespField("name='api-details'")}');
    print('field11: ${tokenResponse.getRespField('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json')}');

    print('field12: ${tokenResponse.getRespField('jasminum floridum')}');
    print('field13: ${tokenResponse.getRespField('GET /api/v1/plant/detail/jasminum%20floridum/')}');
    print('tokenResponse.respMap.values: ${tokenResponse.respMap.values}');

    var field12 = tokenResponse.getRespField('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    //var decode = jsonDecode(field12);
    //print('field12: ${field12}');
    //print('field12: ${decode}');
  }

  static void getData2() async {
    print('============================= GET DATA 2 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    //TODO: non lo trova perché cerca www.open.plantbook.io al posto di open.plantbook.io
    OAuth2Helper oauth2Helper = OAuth2Helper(client, grantType: OAuth2Helper.CLIENT_CREDENTIALS, clientId: clientId, clientSecret: clientSecret, scopes: ['read']); 

    print('client: ${client}');
    print('oauth2Helper: ${oauth2Helper}');
    print('oauth2Helper.getToken(): ${oauth2Helper.getToken()}');
    print('oauth2Helper.accessTokenParams: ${oauth2Helper.accessTokenParams.toString()}');
    print('oauth2Helper.tokenStorage: ${oauth2Helper.tokenStorage.toString()}');
    print('oauth2Helper.webAuthClient: ${oauth2Helper.webAuthClient}');
    print('oauth2Helper.webAuthOpts: ${oauth2Helper.webAuthOpts}');
    print('oauth2Helper.toString(): ${oauth2Helper.toString()}');
    //print('oauth2Helper.fetchToken(): ${oauth2Helper.fetchToken()}');

    Response response = await oauth2Helper.get('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    var decoded = jsonDecode(response.body);
    print('decoded: ${decoded}');
    print('response: ${response}');

  }

}