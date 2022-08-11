import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'dart:convert';

class PlantAPI {

  static const String username = "";
  static const String password = "";
  final String basicAuth = 'Basic ' + base64.encode(utf8.encode('$username:$password'));
  //print(basicAuth); //TODO: remove

  static void getData() async {

    Response response = await get(Uri.https('jsonplaceholder.typicode.com', 'users')); //TODO: jsonplaceholder api for testing
    List<dynamic> data = jsonDecode(response.body);
    //print(data);
    //print(data['title']); //TODO: remove
    print(response.body);

    for (var u in data) {
      print('${u['email']}, ${u['name']}, ${u['username']}');
    }

    //TODO: passare il pid o alias per ottenere l'informazione sulla pianta
    //TODO: https://open.plantbook.io/api/v1/plant/search?alias=acanthus%20ilicifolius
  }

  //Response r = await get(Uri.parse('https://api.somewhere.io'), headers: <String, String>{'authorization': basicAuth}); //TODO: update
  //print(r.statusCode);
  //print(r.body);

}