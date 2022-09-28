import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/database/database_helper.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter_application_prova/widgets/trash_bin_widget/trash_bin_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:developer';
import 'dart:io';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyPlantsScreen extends StatefulWidget {
  const MyPlantsScreen({Key? key}) : super(key: key);

  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: Container( //TODO: dovrà diventare una SingleChildScrollView per quando aumenteranno. (la SingleChildScrollView dava errore)
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: 60,
                child: Text(
                  AppLocalizations.of(context).my_plants,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              /*Flexible(
                child: PlantsList(),
              ),*/
              //ElevatedButton(onPressed: () => getPlants2(), child: const Text('getPlantsInDB')), //TODO: remove
              //ElevatedButton(onPressed: () => deleteAllPlantsFromDB(), child: const Text('delete plants')), //TODO: remove
              FutureBuilder<List<Plant>>(
                future: DatabaseHelper.instance.getPlants(),
                builder: (BuildContext context, AsyncSnapshot<List<Plant>> snapshot) {
                  if(!snapshot.hasData) {
                    return SpinKitCircle(color: Colors.green[900], size: 90.0); //TODO: SpinKitCircle() LoadingScreen();
                  }
                  return snapshot.data!.isEmpty ? 
                  Center(child: Text('No plants in List.')) //TODO: Localizations
                  : ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.map((plant) {
                      return Center(
                        child: ListTile(
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
                                  color: Theme.of(context).textTheme.bodyText1!.color,
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
                          trailing: TrashBinWidget(plant: plant),
                        ),
                      );
                    }).toList(),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: comment or remove
  void getPlants2() async {
    List<Plant> _plants = await DatabaseHelper.instance.getPlants();
    print('_plants2 dal database: ${_plants.toString()}');
    print('_plants2[0]: ${_plants[0].toString()}');
    inspect(_plants); //TODO: remove
  }

  //TODO: comment or remove
  void deleteAllPlantsFromDB() async {
    List<Plant> plantsList = (await DatabaseHelper.instance.getPlants());
    plantsList.forEach((p) async { await DatabaseHelper.instance.remove(p.id != null ? p.id! : 0); });
  }
}
