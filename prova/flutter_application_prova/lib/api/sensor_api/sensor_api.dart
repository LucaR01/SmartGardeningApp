import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/aircare_sensor/aircare_sensor.dart';
import 'package:flutter_application_prova/models/aircare_sensor/health_index.dart';
import 'package:http/http.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

//TODO: volendo si può salvare la stringa dell'access token nelle shared preferences

class SensorOAuth2Client extends OAuth2Client {
  //TODO: togliere authorizeUrl
  SensorOAuth2Client({required String redirectUri, required String customUriScheme})
    : super(authorizeUrl: 'https://api.netatmo.net/oauth2/authorize/', tokenUrl: 'https://api.netatmo.net/oauth2/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) {
      //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO:
  }
}

class SensorOAuth2Client2 extends OAuth2Client { //TODO: remove
  static const String clientId = ''; //TODO: 
  static const String state = 'customstate';
  //TODO: togliere authorizeUrl
  SensorOAuth2Client2({required String redirectUri, required String customUriScheme})
    : super(authorizeUrl: "https://api.netatmo.net/oauth2/authorize?client_id=${clientId}&redirect_uri=''&scope=['read_homecoach']&state=${state}", tokenUrl: 'https://api.netatmo.net/oauth2/token', redirectUri: redirectUri, customUriScheme: customUriScheme) {
      //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO:
  }
}

class SensorOAuth2Client3 extends OAuth2Client { //TODO: remove
  static const String clientId = ''; //TODO: 
  static const String state = 'customstate';
  //TODO: togliere authorizeUrl
  SensorOAuth2Client3({required String redirectUri, required String customUriScheme})
    : super(authorizeUrl: "https://api.netatmo.net/oauth2/authorize?response_type=code&client_id=${clientId}&redirect_uri=''&scope=['read_homecoach']&state=${state}", tokenUrl: 'https://api.netatmo.net/oauth2/token', redirectUri: redirectUri, customUriScheme: customUriScheme) {
      //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO:
  }
}

class SensorOAuth2Client4 extends OAuth2Client { //TODO: remove
  //TODO: togliere authorizeUrl
  SensorOAuth2Client4({required String redirectUri, required String customUriScheme})
    : super(authorizeUrl: "", tokenUrl: 'https://api.netatmo.com/oauth2/token/', redirectUri: redirectUri, customUriScheme: customUriScheme) {
      //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO:
  }
}

class SensorOAuth2Client5 extends OAuth2Client { //TODO: remove
  //TODO: togliere authorizeUrl
  SensorOAuth2Client5({required String redirectUri, required String customUriScheme})
    : super(authorizeUrl: 'https://api.netatmo.net/oauth2/authorize', tokenUrl: 'https://api.netatmo.com/oauth2/token', redirectUri: redirectUri, customUriScheme: customUriScheme) {
      //this.accessTokenRequestHeaders = {'Accept': 'application/json'}; //TODO:
  }
}

//TODO: /gethomecoachsdata; scopes: ['read_homecoach'];

//TODO: https://api.netatmo.net/api/gethomecoachsdata
//TODO: https://api.netatmo.net/api/gethomecoachsdata?device_id=${deviceId}

class SensorAPI {

  static const String clientId = ''; //TODO: 
  static const String clientSecret = ''; //TODO: 

  static const String email = ''; //TODO: 
  static const String password = ''; //TODO: 

  static const String deviceId = ''; //TODO: poi recuperarlo dal field

  static const String state = 'customstate';

  static const String grantTypePassword = 'password';
  static const String grantTypeRefreshToken = 'refresh_token';

  static const String scope = 'read_homecoach';

  static const String method = 'POST';
  static const String charset = 'UTF-8';

  static const String accept = 'application/json';

  //TODO: /gethomecoachsdata=device_id
 
  static final OAuth2Client _client = SensorOAuth2Client(redirectUri: '', customUriScheme: 'open.plantbook.io'); //TODO:

  static Future<AirCareSensor?> getData() async {
    print('======================= GET DATA ==========================================='); //TODO: remove
    try {
      AccessTokenResponse tokenResponse = await _client.getTokenWithClientCredentialsFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['read_homecoach'], httpClient: {'grant_type': 'password','username': email, 'password': password}); //TODO: , httpClient: [email, password]; , httpClient: _client

      if(tokenResponse.isExpired()) {
        print('Token has expired'); //TODO: remove
        tokenResponse = await _client.refreshToken(tokenResponse.refreshToken!, clientId: clientId, clientSecret: clientSecret);
        print('Token has been refreshed'); //TODO: remove
      }

      //TODO: remove prints
      print('client: ${_client.toString()}');
      //print('oauth2Helper: ${tokenResponse}'); //TODO: da errore //TODO: remove
      //print('oauth2Helper.toString(): ${tokenResponse.toString()}'); //TODO: da errore
      print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
      print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
      print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
      print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
      print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
      print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
      print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');

      //Response response = await get(Uri.https('api.netatmo.net', "/oauth2/authorize?grant_type=password&client_id=${clientId}&client_secret=${clientSecret}&username=${email}&password=${password}&scope=['read_homecoach']"), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!}); //TODO: authorize?grant_type=password&client_id=[YOUR_APP_ID]&client_secret=[YOUR_CLIENT_SECRET]&username=[USER_MAIL]&password=[USER_PASSWORD]&scope=[SCOPES_SPACE_SEPARATED]
      //Response response2 = await post(Uri.https('api.netatmo.com', '/api/gethomecoachsdata?device_id=${deviceId}'), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!}); //TODO: 
      //dynamic decodedAircareSensor = jsonDecode(response2.body); //TODO: uncomment
      //print('response.body: ${response.body}'); //TODO: remove
      //print('response2.body: ${response2.body}'); //TODO: remove

      //print('HealthIndex.values[1].toString(): ${HealthIndex.values[1].toString().split('.').last}'); //TODO: remove

      //TODO: decodedAircareSensor['time_utc'] decodedAircareSensor['Temperature'], decodedAircareSensor['CO2'], decodedAircareSensor['Humidity'], decodedAircareSensor['Noise'], decodedAircareSensor['Pressure'], decodedAircareSensor['AbsolutePressure'], Health.values[decodedAircareSensor['health_idx']], decodedAircareSensor['min_temp'], decodedAircareSensor['max_temp'], decodedAircareSensor['date_max_temp'], decodedAircareSensor['date_min_temp']
      return AirCareSensor(timeUtc: '1555677739', temperature: 21.2, co2: 967, humidity: 37, noise: 41, pressure: 45, absolutePressure: 1022.9, healthIndex: HealthIndex.values[1], minTemp: 21.2, maxTemp: 27.4, dateMaxTemp: '1555662436', dateMinTemp: '1555631374'); //TODO: 
    } catch(e)  {
      print('Error: ${e}');
      return null;
    }
  }

  static final OAuth2Client _client2 = SensorOAuth2Client2(redirectUri: '', customUriScheme: 'open.plantbook.io'); //TODO:

  static Future<AirCareSensor?> getData2() async {
    print('======================= GET DATA 2 ==========================================='); //TODO: remove
    try {
      AccessTokenResponse tokenResponse = await _client.getTokenWithAuthCodeFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['read_homecoach'], state: state);

      if(tokenResponse.isExpired()) {
        print('Token has expired'); //TODO: remove
        tokenResponse = await _client.refreshToken(tokenResponse.refreshToken!, clientId: clientId, clientSecret: clientSecret);
        print('Token has been refreshed'); //TODO: remove
      }

      //TODO: remove prints
      print('client: ${_client.toString()}');
      print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
      print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
      print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
      print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
      print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
      print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
      print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');
      //print('oauth2Helper.toString(): ${tokenResponse.toString()}');

      //Response response = await get(Uri.https('api.netatmo.net', "/oauth2/authorize?client_id=${clientId}&redirect_uri='https://auth.netatmo.com/access/login'&scope=['read_homecoach']&state=['STATE_STRING']"), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!});
      Response response2 = await post(Uri.https('api.netatmo.net', '/api/gethomecoachsdata?device_id=${deviceId}'), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!}); //TODO: 
      //dynamic decodedAircareSensor = jsonDecode(response.body); //TODO: uncomment
      //print('response.body: ${response.body}'); //TODO: remove
      print('response.body: ${response2.body}'); //TODO: remove

      //TODO: update to retrieve it from di decodedAircareSensor
      return AirCareSensor(timeUtc: '1555677739', temperature: 21.2, co2: 967, humidity: 37, noise: 41, pressure: 45, absolutePressure: 1022.9, healthIndex: HealthIndex.values[1], minTemp: 21.2, maxTemp: 27.4, dateMaxTemp: '1555662436', dateMinTemp: '1555631374');
    } catch(e) {
      print('Error! Nel catch: ${e}');
      return null;
    }
  }

  //TODO: remove
  /*grant_type=authorization_code&client_id=[YOUR_APP_ID]&client_secret=[YOUR_CLIENT_SECRET]&code=[CODE_RECEIVED_FROM_USER]&redirect_uri=[YOUR_REDIRECT_URI]&scope=[SCOPE_SPACE_SEPARATED] */

  static Future<AirCareSensor?> getData3() async {
    print('======================= GET DATA 3 ==========================================='); //TODO: remove
    OAuth2Helper oauth2Helper = OAuth2Helper(_client, grantType: OAuth2Helper.AUTHORIZATION_CODE, clientId: clientId, clientSecret: clientSecret, scopes: ['read_homecoach']);
    //oauth2Helper.get("https://api.netatmo.net/oauth2/authorize?client_id=${clientId}&redirect_uri='https://auth.netatmo.com/access/login'&scope=['read_homecoach']&state=['STATE_STRING']"); //TODO: /gethomecoachsdata=device_id
    oauth2Helper.post("https://api.netatmo.net/api/gethomecoachsdata?device_id=${deviceId}");

    return null; //TODO: 
  }

  static Future<AirCareSensor?> getData4() async {
    print('======================= GET DATA 4 ==========================================='); //TODO: remove
    OAuth2Helper oauth2Helper = OAuth2Helper(_client, grantType: OAuth2Helper.CLIENT_CREDENTIALS, clientId: clientId, clientSecret: clientSecret, scopes: ['read_homecoach']);
    oauth2Helper.post("https://api.netatmo.net/api/gethomecoachsdata?device_id=${deviceId}"); //TODO: /gethomecoachsdata=device_id

    return null; //TODO: 
  }

  static Future<AirCareSensor?> getData5() async {
    print('======================= GET DATA 5 ==========================================='); //TODO: remove
    //TODO: oauth2/token
    Response response = await post(Uri.https('api.netatmo.com', "/oauth2/token?grant_type=password&client_id=${clientId}&client_secret=${clientSecret}&username=${email}&password=${password}&scope=['read_homecoach']"));
    print('response: ${response.body}');
    //AccessTokenResponse tokenResponse = response.body as AccessTokenResponse;
    //TODO: api.netatmo.net/oauth2/token?grant_type=password&client_id=${clientId}&client_secret=${clientSecret}&username=${email}&password=${password}&scope=['read_homecoach']
    return AirCareSensor(timeUtc: '1555677739', temperature: 21.2, co2: 967, humidity: 37, noise: 41, pressure: 45, absolutePressure: 1022.9, healthIndex: HealthIndex.values[1], minTemp: 21.2, maxTemp: 27.4, dateMaxTemp: '1555662436', dateMinTemp: '1555631374');
  }

  static Future<AirCareSensor?> getData6() async {
    print('======================= GET DATA 6 ==========================================='); //TODO: remove
    Response response = await post(Uri.https('api.netatmo.com', "/oauth2/authorize?client_id=${clientId}&redirect_uri=${_client.redirectUri}&scope=['read_homecoach']&state=[${state}}]"));
    print('response: ${response.body}');
  }

  static Future<AirCareSensor?> getData7() async {
    print('======================= GET DATA 7 ==========================================='); //TODO: remove
    Response response = await post(Uri.https('api.netatmo.com', "/oauth2/authorize?response_type=code&client_id=${clientId}&redirect_uri=${_client.redirectUri}&scope=['read_homecoach']&state=[${state}}]"));
    print('response: ${response.body}');
  }

  static final OAuth2Client _client3 = SensorOAuth2Client4(redirectUri: '', customUriScheme: 'open.plantbook.io'); //TODO:

  static Future<AirCareSensor?> getData8() async {
    print('======================= GET DATA 8 ==========================================='); //TODO: remove
    try {
      AccessTokenResponse tokenResponse = await _client.getTokenWithClientCredentialsFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['read_homecoach']); //TODO: , httpClient: [email, password]; , httpClient: _client

      if(tokenResponse.isExpired()) {
        print('Token has expired'); //TODO: remove
        tokenResponse = await _client.refreshToken(tokenResponse.refreshToken!, clientId: clientId, clientSecret: clientSecret);
        print('Token has been refreshed'); //TODO: remove
      }

      //TODO: remove prints
      print('client: ${_client.toString()}');
      print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
      print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
      print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
      print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
      print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
      print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
      print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');
      //print('oauth2Helper.toString(): ${tokenResponse.toString()}');

      //Response response = await get(Uri.https('api.netatmo.net', "/oauth2/authorize?grant_type=password&client_id=${clientId}&client_secret=${clientSecret}&username=${email}&password=${password}&scope=['read_homecoach']"), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!}); //TODO: authorize?grant_type=password&client_id=[YOUR_APP_ID]&client_secret=[YOUR_CLIENT_SECRET]&username=[USER_MAIL]&password=[USER_PASSWORD]&scope=[SCOPES_SPACE_SEPARATED]
      Response response2 = await post(Uri.https('api.netatmo.net', "/api/gethomecoachsdata?device_id=${deviceId}"), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!}); //TODO: 
      //dynamic decodedAircareSensor = jsonDecode(response2.body); //TODO: uncomment
      //print('response.body: ${response.body}'); //TODO: remove
      print('response2.body: ${response2.body}'); //TODO: remove
      //print('decodedAircareSensor: $decodedAircareSensor');

      print('HealthIndex.values[1].toString(): ${HealthIndex.values[1].toString().split('.').last}'); //TODO: remove

      //TODO: decodedAircareSensor['time_utc'] decodedAircareSensor['Temperature'], decodedAircareSensor['CO2'], decodedAircareSensor['Humidity'], decodedAircareSensor['Noise'], decodedAircareSensor['Pressure'], decodedAircareSensor['AbsolutePressure'], Health.values[decodedAircareSensor['health_idx']], decodedAircareSensor['min_temp'], decodedAircareSensor['max_temp'], decodedAircareSensor['date_max_temp'], decodedAircareSensor['date_min_temp']
      return AirCareSensor(timeUtc: '1555677739', temperature: 21.2, co2: 967, humidity: 37, noise: 41, pressure: 45, absolutePressure: 1022.9, healthIndex: HealthIndex.values[1], minTemp: 21.2, maxTemp: 27.4, dateMaxTemp: '1555662436', dateMinTemp: '1555631374'); //TODO: 
    } catch(e)  {
      print('Error: ${e}');
      return null;
    }
  }

  static final OAuth2Client _client4 = SensorOAuth2Client5(redirectUri: '', customUriScheme: 'open.plantbook.io'); //TODO:

  static Future<AirCareSensor?> getData9() async {
    print('======================= GET DATA 9 ==========================================='); //TODO: remove
    try {
      AccessTokenResponse tokenResponse = await _client4.getTokenWithAuthCodeFlow(clientId: clientId, clientSecret: clientSecret, scopes: ['read_homecoach'], enableState: true, state: state); //TODO: , httpClient: [email, password] non andava così; , httpClient: _client non ha senso così (credo)

      if(tokenResponse.isExpired()) {
        print('Token has expired'); //TODO: remove
        tokenResponse = await _client.refreshToken(tokenResponse.refreshToken!, clientId: clientId, clientSecret: clientSecret);
        print('Token has been refreshed'); //TODO: remove
      }

      //TODO: remove prints
      print('client: ${_client.toString()}');
      //print('oauth2Helper.toString(): ${tokenResponse.toString()}'); //TODO: da errore
      print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
      print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
      print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
      print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
      print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
      print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
      print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');

      //Response response = await get(Uri.https('api.netatmo.net', "/oauth2/authorize?grant_type=password&client_id=${clientId}&client_secret=${clientSecret}&username=${email}&password=${password}&scope=['read_homecoach']"), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!}); //TODO: authorize?grant_type=password&client_id=[YOUR_APP_ID]&client_secret=[YOUR_CLIENT_SECRET]&username=[USER_MAIL]&password=[USER_PASSWORD]&scope=[SCOPES_SPACE_SEPARATED]
      Response response2 = await post(Uri.https('api.netatmo.net', '/api/gethomecoachsdata?device_id=${deviceId}'), headers: <String, String>{'Authorization': 'Bearer ' + tokenResponse.accessToken!}); //TODO: 
      //dynamic decodedAircareSensor = jsonDecode(response2.body); //TODO: uncomment
      //print('response.body: ${response.body}'); //TODO: remove
      print('response2.body: ${response2.body}'); //TODO: remove

      //print('HealthIndex.values[1].toString(): ${HealthIndex.values[1].toString().split('.').last}'); //TODO: remove

      //TODO: decodedAircareSensor['time_utc'] decodedAircareSensor['Temperature'], decodedAircareSensor['CO2'], decodedAircareSensor['Humidity'], decodedAircareSensor['Noise'], decodedAircareSensor['Pressure'], decodedAircareSensor['AbsolutePressure'], Health.values[decodedAircareSensor['health_idx']], decodedAircareSensor['min_temp'], decodedAircareSensor['max_temp'], decodedAircareSensor['date_max_temp'], decodedAircareSensor['date_min_temp']
      return AirCareSensor(timeUtc: '1555677739', temperature: 21.2, co2: 967, humidity: 37, noise: 41, pressure: 45, absolutePressure: 1022.9, healthIndex: HealthIndex.values[1], minTemp: 21.2, maxTemp: 27.4, dateMaxTemp: '1555662436', dateMinTemp: '1555631374'); //TODO: 
    } catch(e)  {
      print('Error: ${e}');
      return null;
    }
  }

  static Future<AirCareSensor?> getData11() async {
    print('======================= GET DATA 11 ==========================================='); //TODO: remove
    Response response = await post(Uri.https('api.netatmo.com', '/oauth2/token', {'grant_type': grantTypePassword, 'client_id': clientId, 'client_secret': clientSecret, 'username': email, 'password': password, 'scope': scope}));
    print('response: ${response.body}');
    print('${Uri.https('api.netatmo.com', '/oauth2/token', {'grant_type': grantTypePassword, 'client_id': clientId, 'client_secret': clientSecret, 'username': email, 'password': password, 'scope': scope}).toString()}');
    print('${Uri.https('api.netatmo.com', '/oauth2/token', {'grant_type': grantTypePassword, 'client_id': clientId, 'client_secret': clientSecret, 'username': email, 'password': password, 'scope': scope}).path}');
    print('${Uri.https('api.netatmo.com', '/oauth2/token', {'grant_type': grantTypePassword, 'client_id': clientId, 'client_secret': clientSecret, 'username': email, 'password': password, 'scope': scope}).scheme}');
    return null;
  }

  static Future<AirCareSensor?> getData12() async {
    print('======================= GET DATA 12 ==========================================='); //TODO: remove
    Response response = await post(Uri.https('api.netatmo.com', '/oauth2/token'), headers: <String, String>{'grant_type': grantTypePassword, 'client_id': clientId, 'client_secret': clientSecret, 'username': email, 'password': password, 'scope': scope}, encoding: Encoding.getByName('UTF-8'));
    print('response: ${response.body}');
    print('response.headers : ${response.headers}');
    return null;
  }

  //TODO: return o void o AccessToken (meglio restituire l'accesstoken)
  //TODO: rename in getAccessToken()
  //TODO: questa credo che possa anche non essere statica
  static Future<String?> getData10() async {
    print('======================= GET DATA 10 ==========================================='); //TODO: remove

    var headers = {
    'Accept-Charset': 'UTF-8',
    'Content-Type': 'application/x-www-form-urlencoded'
    };

    var request = Request('POST', Uri.parse('https://api.netatmo.com/oauth2/token')); //TODO: forse si poteva anche scrivere Uri.https('', '', headers: , {'': ''})
    request.bodyFields = { //TODO: usare le variabili
      'grant_type': grantTypePassword,
      'client_id': clientId,
      'client_secret': clientSecret,
      'username': email,
      'password': password,
      'scope': scope
    };
    request.headers.addAll(headers);

    print('request.url: ${request.url}'); //TODO: remove

    //StreamedResponse response = await request.send();

    Response response = await Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      /*String s = await response.stream.bytesToString(); //TODO: 
      Map<String, dynamic> map = jsonDecode(s);
      print(s);
      print('s[""]: ${s[0]}');
      print('map[""]: ${map["access_token"]}');
      print('jsonDecode: ${jsonDecode(s)}');
      print('request.body: ${request.body}');
      print('request.bodyFields: ${request.bodyFields}');
      print('request.bodyBytes: ${request.bodyBytes}');*/

      AccessTokenResponse tokenResponse = AccessTokenResponse.fromHttpResponse(response);
      print('tokenResponse.expiresIn: ${tokenResponse.expiresIn.toString()}');
      print('tokenResponse.scope: ${tokenResponse.scope.toString()}');
      print('tokenResponse.tokenType: ${tokenResponse.tokenType.toString()}');
      print('tokenResponse.httpStatusCode: ${tokenResponse.httpStatusCode.toString()}');
      print('tokenResponse.expirationDate: ${tokenResponse.expirationDate.toString()}');
      print('tokenResponse.isValid(): ${tokenResponse.isValid()}');
      print('tokenResponse.accessToken: ${tokenResponse.accessToken.toString()}');

      //print('s as Reponse ${s as Response}'); //TODO: non si può fare!
      //print('request.send(): ${request.send()}');
      //print('jsonDecode: ${jsonDecode(request.body)}');
      //TODO: cast da response.body a AccessToken
      //TODO: getAirCareSensorData(passare come parametro l'AccessToken);
      //AccessTokenResponse tokenResponse = s as AccessTokenResponse;
      //AccessTokenResponse tokenResponse2 = request.body as AccessTokenResponse;
      //AccessTokenResponse tokenResponse3 = map as AccessTokenResponse; //TODO: non funziona
      //AccessTokenResponse tokenResponse = AccessTokenResponse.fromHttpResponse(s as Response);

      /*Response r = await Response.fromStream(response);
      AccessTokenResponse tokenResponse= AccessTokenResponse.fromHttpResponse(r);*/

      //inspect(tokenResponse);
      //inspect(tokenResponse2);
      //inspect(tokenResponse3);

      dynamic map = jsonDecode(response.body);
      print('jsonDecode(response.body): ${map}');

      return map["access_token"];
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

  static Future<AccessTokenResponse?> _getAccessTokenResponse() async {
    var headers = {
    'Accept-Charset': 'UTF-8',
    'Content-Type': 'application/x-www-form-urlencoded'
    };

    var request = Request('POST', Uri.parse('https://api.netatmo.com/oauth2/token')); 
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

    if (response.statusCode == 200) {
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

  //TODO: dovrà prendere un AccessToken
  static Future<AirCareSensor?> getAirCareSensorData({required int deviceId}) async {

    //TODO: mi servirebbe un AccessTokenResponse anche per poter controllare se è expired()

    //String? accessToken = await getData10(); //TODO: String? o Map<String, dynamic>?

    AccessTokenResponse? tokenResponse = await _getAccessTokenResponse();

    if(tokenResponse == null) {
      print('Error: AccessToken is null!');
    } else {
      if(tokenResponse.isExpired()) {
        var headers = {
          'Accept-Charset': 'UTF-8',
          'Content-Type': 'application/x-www-form-urlencoded'
        };

        var refreshTokenRequest = Request('POST', Uri.parse('https://api.netatmo.com/oauth2/token'));

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
    'Accept': 'application/json',
    'Authorization': 'Bearer ${tokenResponse!.accessToken}' 
    };

    var AirCareSensorDataRequest = Request('POST', Uri.parse('https://api.netatmo.com/api/gethomecoachsdata?device_id=$deviceId'));
    AirCareSensorDataRequest.headers.addAll(headers);

    StreamedResponse response = await AirCareSensorDataRequest.send();

    if (response.statusCode == 200) {
      String airCareSensorData = await response.stream.bytesToString();
      print('airCareSensorData: $airCareSensorData');
      Map<String, dynamic> decodedAirCareSensorData = jsonDecode(airCareSensorData);
      print('decodedAirCareSensorData: $decodedAirCareSensorData');
      return AirCareSensor(timeUtc: decodedAirCareSensorData['time_utc'], temperature: decodedAirCareSensorData['Temperature'], co2: decodedAirCareSensorData['CO2'], humidity: decodedAirCareSensorData['Humidity'], noise: decodedAirCareSensorData['Noise'], pressure: decodedAirCareSensorData['Pressure'], absolutePressure: decodedAirCareSensorData['AbsolutePressure'], healthIndex: HealthIndex.values[decodedAirCareSensorData['health_idx']], minTemp: decodedAirCareSensorData['min_temp'], maxTemp: decodedAirCareSensorData['max_temp'], dateMaxTemp: decodedAirCareSensorData['date_max_temp'], dateMinTemp: decodedAirCareSensorData['date_min_temp']);
    }
    else {
      print(response.reasonPhrase);
    }

    return null; //TODO: 
  }

}