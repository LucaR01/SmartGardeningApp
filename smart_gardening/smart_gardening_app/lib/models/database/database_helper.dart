import 'package:smart_gardening_app/constants/constants.dart';
import 'package:smart_gardening_app/models/plant/plant.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  /// It inits the database by creating a new db called [Constants.databaseName] in the user's documents [Directory].
  /// It returns a [Database] if everything successed.
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '${Constants.databaseName}${Constants.databaseExtension}');

    print('path: ${path}'); //TODO: remove
    print('documentsDirectory.path: ${documentsDirectory.path}'); //TODO: remove

    return await openDatabase( //TODO: Error: Attempt to write a readonly database
      path,
      version: 1,
      readOnly: false,
      onCreate: _onCreate,
    );
  }

  /// It creates the table by executing the query.
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

  /// It returns all the plants [Plant] in the database.
  /// If there are none, it returns an empty list.
  Future<List<Plant>> getPlants() async {
    Database db = await instance.database;
    var plants = await db.query(Constants.databaseName, orderBy: 'id');
    List<Plant> plantsList = plants.isNotEmpty ? plants.map((p) => Plant.fromMap(p)).toList() : []; //oppure : List.toEmpty() 
    print('plantsList: ${plantsList.toString()}'); //TODO: remove
    return plantsList;
  }

  /// It executes the query and adds a new [Plant] to the database.
  Future<int> add(Plant plant) async {
    Database db = await instance.database;
    return await db.insert(Constants.databaseName, plant.toMap());
  }

  /// It removes a [Plant] from the [DatabaseHelper.instance] based on the plant's [id].
  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(Constants.databaseName, where: 'id = ?', whereArgs: [id]);
  }

  /// It updates the data of a [Plant] based on the [id] and the new [plant] passed.
  Future<int> update(Plant plant, int id) async {
    Database db = await instance.database;
    return await db.update(Constants.databaseName, plant.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  /// It closes the database.
  Future close() async {
    Database db = await instance.database;
    db.close();
  }
}