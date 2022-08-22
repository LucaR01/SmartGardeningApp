import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:oauth2_client/interfaces.dart';
import 'dart:convert';
//import 'package:oauth2/oauth2.dart'; //TODO: remove
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';

//TODO: aggiungere nel manifest di android per far funzionare il package oauth2_client e cambiare il PodFile di iOS
//TODO: Bearer realm="api"
//TODO: Salvare il token nelle SharedPreferences?

//TODO: getData2/4/8/9/13 non funzionano e credo perché fa un host failed lookup perché cerca www.open.plantbook.io al posto di open.plantbook.io (nella maggior parte di questi)
//TODO: il resto dei getData funziona.
//TODO: PlantBookOAuth2Client da utilizzare sono il 5 e il 6.

class PlantBookOAuth2Client extends OAuth2Client { 
  PlantBookOAuth2Client({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: 'https://open.plantbook.io/social-auth/', tokenUrl: 'https://open.plantbook.io/api/v1/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) { //TODO: aggiungere authorizeUrl e tokenUrl
    //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO: uncomment
  } //TODO: token/name='token'; https://open.plantbook.io/social-auth/
}

class PlantBookOAuth2Client2 extends OAuth2Client { 
  PlantBookOAuth2Client2({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: 'https://open.plantbook.io/api/v1/token/', tokenUrl: 'https://open.plantbook.io/api/v1/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) { //TODO: aggiungere authorizeUrl e tokenUrl
    //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO: uncomment
  } //TODO: token/name='token'; https://open.plantbook.io/social-auth/
}

class PlantBookOAuth2Client3 extends OAuth2Client { 
  PlantBookOAuth2Client3({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: 'https://open.plantbook.io/api/v1/token/', tokenUrl: 'https://open.plantbook.io/api/v1/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) { //TODO: aggiungere authorizeUrl e tokenUrl
    //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO: uncomment
  } //TODO: token/name='token'; https://open.plantbook.io/social-auth/
}

class PlantBookOAuth2Client4 extends OAuth2Client { 
  PlantBookOAuth2Client4({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: 'https://open.plantbook.io/apikey/', tokenUrl: 'https://open.plantbook.io/apikey/', redirectUri: redirectUri, customUriScheme: customUriScheme) { //TODO: aggiungere authorizeUrl e tokenUrl
    //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO: uncomment
  } //TODO: token/name='token'; https://open.plantbook.io/social-auth/
}

class PlantBookOAuth2Client5 extends OAuth2Client { 
  PlantBookOAuth2Client5({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: '', tokenUrl: 'https://open.plantbook.io/api/v1/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) { //TODO: aggiungere authorizeUrl e tokenUrl
    //this.accessTokenRequestHeaders = {'Content-Type': 'application/json'}; //TODO: uncomment; sembra non andare
  } //TODO: token/name='token'; https://open.plantbook.io/social-auth/
}

class PlantBookOAuth2Client6 extends OAuth2Client { 
  PlantBookOAuth2Client6({required String redirectUri, required String customUriScheme}) 
  : super(authorizeUrl: 'noauth', tokenUrl: 'https://open.plantbook.io/api/v1/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) { //TODO: aggiungere authorizeUrl e tokenUrl
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
    Response response3 = await get('https://open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json' as Uri); //TODO: remove
    //List<dynamic> data = jsonDecode(response.body);
    //print(data);
    //print(data['title']); //TODO: remove
    print(response.body);
    print('RESPONSE2: ${response2.body}');
    print('RESPONSE3: ${response2.body}');

    /*for (var u in data) {
      print('${u['email']}, ${u['name']}, ${u['username']}');
    }*/

    //TODO: passare il pid o alias per ottenere l'informazione sulla pianta
    //TODO: https://open.plantbook.io/api/v1/plant/search?alias=acanthus%20ilicifolius
    //TODO: api/v1/plant/detail/ /?format=json
  }

  //Response r = await get(Uri.parse('https://api.somewhere.io'), headers: <String, String>{'Authorization': 'Bearer' + }); //TODO: update
  //print(r.statusCode);
  //print(r.body);

  //TODO: static?
  //TODO: aggiungere redirect e customUri

  //TODO: rename in getData
  //TODO: remove?
  static void getData2() async {
    print('============================= GET DATA 2 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    //AccessTokenResponse tokenResponse = await client.getTokenWithAuthCodeFlow(clientId: '', clientSecret: '', scopes: ['']); //TODO: 
    AccessTokenResponse tokenResponse = await client.getTokenWithClientCredentialsFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['https://www.open.plantbook.io/api/v1/plant/detail/']); //TODO: 

    if (tokenResponse.isExpired()) {
      tokenResponse = await client.refreshToken(tokenResponse.refreshToken!, clientId: clientId);
    }

    //TODO: remove
    print('client: ${client.toString()}');
    print('tokenResponse: ${tokenResponse}');
    print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
    print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
    print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
    print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
    print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
    print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
    print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');
    print('oauth2Helper.toString(): ${tokenResponse.toString()}');

    Response response = await get(Uri.https('open.plantbook.io', '/api/v1/plant/detail/jasminum%20floridum/?format=json'), headers: {'Authorization': 'Bearer' + tokenResponse.accessToken!}); //TODO: 
  }

  static void getData3() async {
    print('============================= GET DATA 3 ======================================'); //TODO: remove
    OAuth2Client client = PlantBookOAuth2Client(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io'); //redirectUri: open.plantbook.io:/api/v1/plant/detail/jasminum%20floridum/?format=json

    OAuth2Helper oauth2Helper = OAuth2Helper(client, grantType: OAuth2Helper.CLIENT_CREDENTIALS, clientId: clientId, clientSecret: clientSecret); //TODO: https://open.plantbook.io/login/?next=/apikey/show/; gli scopes non servono per credentials_flow

    //TODO: remove prints
    print('client: ${client}');
    print('client: ${client.toString()}');
    print('oauth2Helper: ${oauth2Helper}');
    print('oauth2Helper.getToken(): ${oauth2Helper.getToken()}');
    print('oauth2Helper.accessTokenParams: ${oauth2Helper.accessTokenParams.toString()}');
    print('oauth2Helper.tokenStorage: ${oauth2Helper.tokenStorage.toString()}');
    print('oauth2Helper.webAuthClient: ${oauth2Helper.webAuthClient}');
    print('oauth2Helper.webAuthOpts: ${oauth2Helper.webAuthOpts}');
    print('oauth2Helper.toString(): ${oauth2Helper.toString()}');
    print('oauth2Helper.fetchToken(): ${oauth2Helper.fetchToken()}');
    Response response = await oauth2Helper.get('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    //Response response = await oauth2Helper.get('https://www.open.plantbook.io'); //TODO: remove
    //Response response = await get(Uri.https('open.plantbook.io', '/api/v1/plant/detail/jasminum%20floridum/?format=json')); //TODO: remove; questo funziona!
    print(jsonDecode(response.body));
  }

  static void getData4() async {
    print('============================= GET DATA 4 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    OAuth2Helper oauth2Helper = OAuth2Helper(client, grantType: OAuth2Helper.AUTHORIZATION_CODE, clientId: clientId, clientSecret: clientSecret, scopes: ['https://open.plantbook.io/api/v1/plant/search']);

    Response response = await oauth2Helper.get('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    print(response.body);
  }

  //TODO: scope='read'
  //TODO: key='nome_pianta'
  //TODO: /api/v1/plant/
  //TODO: auth=noauth?

  static void getData5() async {
    print('============================= GET DATA 5 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client2(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    AccessTokenResponse tokenResponse = await client.getTokenWithClientCredentialsFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['read']);

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

    var field = tokenResponse.getRespField('pid'); //TODO: search?
    print('field: ${field}');
  }

  static void getData6() async {
    print('============================= GET DATA 6 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client3(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    OAuth2Helper oauth2Helper = OAuth2Helper(client, grantType: OAuth2Helper.CLIENT_CREDENTIALS, clientId: clientId, clientSecret: clientSecret);

    //TODO: remove prints
    print('client: ${client}');
    print('oauth2Helper: ${oauth2Helper}');
    print('oauth2Helper.getToken(): ${oauth2Helper.getToken()}');
    print('oauth2Helper.accessTokenParams: ${oauth2Helper.accessTokenParams.toString()}');
    print('oauth2Helper.tokenStorage: ${oauth2Helper.tokenStorage.toString()}');
    print('oauth2Helper.webAuthClient: ${oauth2Helper.webAuthClient.toString()}');
    print('oauth2Helper.webAuthOpts: ${oauth2Helper.webAuthOpts}');
    print('oauth2Helper.toString(): ${oauth2Helper.toString()}');
    print('oauth2Helper.fetchToken(): ${oauth2Helper.fetchToken()}');

    Response response = await oauth2Helper.get('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    print(jsonDecode(response.body));

  }

  static void getData7() async {
    print('============================= GET DATA 7 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client4(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    OAuth2Helper oauth2Helper = OAuth2Helper(client, grantType: OAuth2Helper.CLIENT_CREDENTIALS, clientId: clientId, clientSecret: clientSecret);

    //TODO: remove prints
    print('client: ${client}');
    print('oauth2Helper: ${oauth2Helper}');
    print('oauth2Helper.getToken(): ${oauth2Helper.getToken()}');
    print('oauth2Helper.accessTokenParams: ${oauth2Helper.accessTokenParams.toString()}');
    print('oauth2Helper.tokenStorage: ${oauth2Helper.tokenStorage.toString()}');
    print('oauth2Helper.webAuthClient: ${oauth2Helper.webAuthClient}');
    print('oauth2Helper.webAuthOpts: ${oauth2Helper.webAuthOpts}');
    print('oauth2Helper.toString(): ${oauth2Helper.toString()}');
    print('oauth2Helper.fetchToken(): ${oauth2Helper.fetchToken()}');

    Response response = await oauth2Helper.get('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    print(jsonDecode(response.body));

  }

  static void getData8() async {
    print('============================= GET DATA 8 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client5(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    OAuth2Helper oauth2Helper = OAuth2Helper(client, grantType: OAuth2Helper.CLIENT_CREDENTIALS, clientId: clientId, clientSecret: clientSecret);

    //TODO: remove prints
    print('client: ${client}');
    print('oauth2Helper: ${oauth2Helper}');
    print('oauth2Helper.getToken(): ${oauth2Helper.getToken()}');
    print('oauth2Helper.accessTokenParams: ${oauth2Helper.accessTokenParams.toString()}');
    print('oauth2Helper.tokenStorage: ${oauth2Helper.tokenStorage.toString()}');
    print('oauth2Helper.webAuthClient: ${oauth2Helper.webAuthClient}');
    print('oauth2Helper.webAuthOpts: ${oauth2Helper.webAuthOpts}');
    print('oauth2Helper.toString(): ${oauth2Helper.toString()}');
    print('oauth2Helper.fetchToken(): ${oauth2Helper.fetchToken()}');

    Response response = await oauth2Helper.get('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    print(jsonDecode(response.body));

  }

  static void getData9() async {
    print('============================= GET DATA 9 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client6(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    OAuth2Helper oauth2Helper = OAuth2Helper(client, grantType: OAuth2Helper.CLIENT_CREDENTIALS, clientId: clientId, clientSecret: clientSecret);

    //TODO: remove prints
    print('client: ${client}');
    print('oauth2Helper: ${oauth2Helper}');
    print('oauth2Helper.getToken(): ${oauth2Helper.getToken()}');
    print('oauth2Helper.accessTokenParams: ${oauth2Helper.accessTokenParams.toString()}');
    print('oauth2Helper.tokenStorage: ${oauth2Helper.tokenStorage.toString()}');
    print('oauth2Helper.webAuthClient: ${oauth2Helper.webAuthClient.toString()}');
    print('oauth2Helper.webAuthOpts: ${oauth2Helper.webAuthOpts.toString()}');
    print('oauth2Helper.toString(): ${oauth2Helper.toString()}');
    print('oauth2Helper.fetchToken(): ${oauth2Helper.fetchToken()}');

    Response response = await oauth2Helper.get('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');
    print(jsonDecode(response.body));

  }

  static void getData10() async {
    print('============================= GET DATA 10 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client5(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    AccessTokenResponse tokenResponse = await client.getTokenWithClientCredentialsFlow(clientId: clientId, clientSecret: clientSecret);

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

    var field = tokenResponse.getRespField('pid'); //TODO: search?
    print('field: ${field}');
  }

  static void getData11() async {
    print('============================= GET DATA 11 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client5(redirectUri: 'open.plantbook.io://oauth2redirect', customUriScheme: 'open.plantbook.io');

    AccessTokenResponse tokenResponse = await client.getTokenWithClientCredentialsFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['read']);

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

    var field = tokenResponse.getRespField('pid'); //TODO: search?
    print('field: ${field}');

    print('field2: ${tokenResponse.getRespField('jasminum%20floridum')}');
    print('field3: ${tokenResponse.getRespField('jasminum floridum')}');
    print('field4: ${tokenResponse.getRespField('search/jasminum floridum')}');
    print('field5: ${tokenResponse.getRespField('plant/detail/jasminum floridum')}');
    print('field6: ${tokenResponse.getRespField('jasminum floridum/?format=json')}');
    print('field7: ${tokenResponse.getRespField('/api/v1/plant/detail/jasminum%20floridum/')}');
    
    print('field8: ${tokenResponse.getRespField('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json')}');
  }

  static void getData12() async {
    print('============================= GET DATA 12 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client6(redirectUri: 'open.plantbook.io:/open.plantbook.io/login/?next=/browse-db/?contain=jasminum+floridum', customUriScheme: 'open.plantbook.io');

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

    /*var field = tokenResponse.getRespField('pid'); //TODO: search?
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

    var field12 = tokenResponse.getRespField('https://www.open.plantbook.io/api/v1/plant/detail/jasminum%20floridum/?format=json');*/
    //var decode = jsonDecode(field12);
    //print('field12: ${field12}');
    //print('field12: ${decode}');
  }

  static void getData13() async {
    print('============================= GET DATA 13 ======================================'); //TODO: remove

    OAuth2Client client = PlantBookOAuth2Client6(redirectUri: 'open.plantbook.io/login/?next=/browse-db/?contain=jasminum+floridum', customUriScheme: 'open.plantbook.io');

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