import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/database/database_helper.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';

class PlantsList extends StatefulWidget {
  const PlantsList({Key? key}) : super(key: key);

  @override
  State<PlantsList> createState() => _PlantsListState();
}

class _PlantsListState extends State<PlantsList> {
List<Widget> _plantsList = [];
final GlobalKey _listKey = GlobalKey();

@override
  void initState() {
    super.initState();
    _getPlants(); //TODO: _addPlants();
    //TODO: getPlantsFromDatabase/Local Memory
  }

  //TODO: rinominare in getPlantsFromDB() or getPlantsFromDatabase()
  //TODO: add async to function
  void _getPlants() async {
    /*List<Plant> _plants = [
      Plant(id: 0, pid: 'Gelsomino', displayPid: 'Gelsomino', alias: 'gelsomino', maxLightMmol: 0, minLightMmol: 0, maxLightLux: 0, minLightLux: 0, maxTemp: 0, minTemp: 0, maxEnvHumid: 0, minEnvHumid: 0, maxSoilMoist: 0, minSoilMoist: 0, maxSoilEC: 0, minSoilEC: 0, imageUrl: 'gelsomono_mamertino.png', accuracy: 7.9),
      Plant(id: 1, pid: 'Margherita', displayPid: 'Margherita', alias: 'margherita', maxLightMmol: 0, minLightMmol: 0, maxLightLux: 0, minLightLux: 0, maxTemp: 0, minTemp: 0, maxEnvHumid: 0, minEnvHumid: 0, maxSoilMoist: 0, minSoilMoist: 0, maxSoilEC: 0, minSoilEC: 0, imageUrl: 'margherita-grande-come-curare-come-si-coltiva.png', accuracy: 9.2)
    ];*/

    List<Plant> _plants = await DatabaseHelper.instance.getPlants(); //TODO: uncomment rinominare in _plants 
    print('_plants dal database: ${_plants.toString()}');
    print('_plants2[0]: ${_plants[0].toString()}');
    inspect(_plants); //TODO: remove

    _plants.forEach((Plant plant) {
      _plantsList.add(_buildPlant(plant));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, //TODO: remove
      key: _listKey,
      itemCount: _plantsList.length,
      itemBuilder: (context, index) {
        return _plantsList[index];
      }

    );
  }

  //TODO: remove
  void getPlants2() async {
    List<Plant> _plants2 = await DatabaseHelper.instance.getPlants(); //TODO: uncomment rinominare in _plants 
    print('_plants2 dal database');
    inspect(_plants2); //TODO: remove
  }

  //TODO: potrei fare una card per pianta piuttosto.
  Widget _buildPlant(Plant plant) {
    return ListTile(
      onTap: () => Utils.navigateToPage(context: context, page: Pages.myPlantsDetails, plant: plant),
      contentPadding: EdgeInsets.all(24),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text(
            'Nome: ${plant.pid}', //TODO: use string constants
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green[300], //TODO: use color constants
            ),
          ),
        ],
      ),
      leading: ClipRect(
        //TODO: borderRadius:
        /*child: Image.asset(
          'assets/images/scan/${plant.imageUrl}',
          height: 50.0, //TODO: 60.0
        ),*/
        child: Image.network(
          plant.imageUrl,
          height: 50.0,
        ),
      ),
      trailing: Icon(Icons.favorite), //TODO: FavoriteWidget()
    );
  }
}