import 'package:flutter/material.dart';
import 'package:smart_gardening_app/models/plant/plant.dart';
import 'package:smart_gardening_app/screens/pages.dart';
import 'package:smart_gardening_app/utils/utils.dart';

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

  void _getPlants() {
    //TODO: vanno recuperati o dal database o dalla memoria locale dell'utente.
    List<Plant> _plants = [
      Plant(name: 'Gelsomino', family: 'Famiglia Gelsomino', waterAmount: 12, sunAmount: 13, 
      description: 'Descrizione Gelsomino', otherDescription: 'Altra Descrizione Gelsomino', plantAccuracy: 56.7, img: 'gelsomono_mamertino.png'),
      Plant(name: 'Margherita', family: 'Famiglia Margherita', waterAmount: 12, sunAmount: 13, 
      description: 'Descrizione Margherita', otherDescription: 'Altra Descrizione Margherita', plantAccuracy: 72.9, img: 'margherita-grande-come-curare-come-si-coltiva.png'),
    ];

    _plants.forEach((Plant plant) {
      _plantsList.add(_buildPlant(plant));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: _listKey,
      itemCount: _plantsList.length,
      itemBuilder: (context, index) {
        return _plantsList[index];
      }

    );
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
            'Nome: ${plant.name}', //TODO: use string constants
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
        child: Image.asset(
          'assets/images/scan/${plant.img}',
          height: 50.0, //TODO: 60.0
        ),
      ),
      trailing: Icon(Icons.favorite), //TODO: HeartWidget()
    );
  }
}