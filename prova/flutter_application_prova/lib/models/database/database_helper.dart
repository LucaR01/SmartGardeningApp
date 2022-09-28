import 'package:flutter/material.dart';
import 'package:flutter_application_prova/constants/constants.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'plants.db');

    print('path: ${path}'); //TODO: remove
    print('documentsDirectory.path: ${documentsDirectory.path}'); //TODO: remove

    return await openDatabase( //TODO: Error: Attempt to write a readonly database
      path,
      version: 1,
      readOnly: false,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async { //TODO: volendo aggiungere il NOT NULL
    await db.execute('''
      CREATE TABLE plants(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        pid TEXT NOT NULL,
        displayPid TEXT NOT NULL,
        alias TEXT NOT NULL,
        maxLightMmol INTEGER,
        minLightMmol INTEGER,
        maxLightLux INTEGER,
        minLightLux INTEGER,
        maxTemp INTEGER,
        minTemp INTEGER,
        maxEnvHumid INTEGER,
        minEnvHumid INTEGER,
        maxSoilMoist INTEGER,
        minSoilMoist INTEGER,
        maxSoilEC INTEGER,
        minSoilEC INTEGER,
        imageUrl TEXT,
        accuracy DOUBLE
      )
    ''');
  }

  Future<List<Plant>> getPlants() async {
    Database db = await instance.database;
    var plants = await db.query(Constants.databaseName, orderBy: 'id');
    List<Plant> plantsList = plants.isNotEmpty ? plants.map((p) => Plant.fromMap(p)).toList() : []; //oppure : List.toEmpty() 
    print('plantsList: ${plantsList.toString()}'); //TODO: remove
    return plantsList;
  }

  Future<int> add(Plant plant) async {
    Database db = await instance.database;
    return await db.insert(Constants.databaseName, plant.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(Constants.databaseName, where: 'id = ?', whereArgs: [id]); //TODO: al posto di mettere 'plants' mettere DatabaseHelper.databaseName; pid = ?
  }

  Future<int> update(Plant plant) async {
    Database db = await instance.database;
    return await db.update(Constants.databaseName, plant.toMap(), where: 'id = ?', whereArgs: [plant.id]);
  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }
}