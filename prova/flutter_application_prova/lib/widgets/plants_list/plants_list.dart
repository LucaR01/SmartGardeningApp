import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/database/database_helper.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:flutter_application_prova/widgets/trash_bin_widget/trash_bin_widget.dart';

import 'dart:developer';
import 'dart:io';

class PlantsList extends StatefulWidget {
  const PlantsList({Key? key}) : super(key: key);

  @override
  State<PlantsList> createState() => _PlantsListState();
}

class _PlantsListState extends State<PlantsList> {
final List<Widget> _plantsList = [];
final GlobalKey _listKey = GlobalKey();

@override
  void initState() {
    super.initState();
    _getPlantsFromDB();
  }

  void _getPlantsFromDB() async {
    List<Plant> _plants = await DatabaseHelper.instance.getPlants();
    print('_plants dal database: ${_plants.toString()}');
    print('_plants2[0]: ${_plants[0].toString()}');
    //inspect(_plants); //TODO: remove

    _plants.forEach((Plant plant) {
      _plantsList.add(_buildPlant(plant));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      key: _listKey,
      itemCount: _plantsList.length,
      itemBuilder: (context, index) {
        return _plantsList[index];
      }

    );
  }

  Widget _buildPlant(Plant plant) {
    return ListTile(
      onTap: () => Utils.navigateToPage(context: context, page: Pages.myPlantsDetails, plant: plant),
      contentPadding: const EdgeInsets.all(24),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text(
            'Nome: ${plant.pid}', //TODO: localizations
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ],
      ),
      leading: ClipRect(
        child: Image.file(
          File(plant.imageUrl),
          height: 50.0,
        ),
      ),
      trailing: TrashBinWidget(plant: plant), // prima era Icons.favorite
    );
  }
}