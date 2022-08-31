import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/database/database_helper.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:flutter_application_prova/widgets/plants_list/plants_list.dart';

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
      /*body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(""),
          ),
        ),
      ),*/
      body: Container( //TODO: dovrà diventare una SingleChildScrollView per quando aumenteranno. (la SingleChildScrollView dava errore)
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              SizedBox(
                height: 60,
                child: Text(
                  'My Plants',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              /*Flexible( //TODO: ListView?, SingleChildScrollView?
                child: PlantsList(),
              ),*/
              ElevatedButton(onPressed: () => getPlants2(), child: const Text('getPlantsInDB')), //TODO: remove
              ElevatedButton(onPressed: () => deleteAllPlantsFromDB(), child: const Text('delete plants')), //TODO: remove
              //TODO: 
              FutureBuilder<List<Plant>>(
                future: DatabaseHelper.instance.getPlants(),
                builder: (BuildContext context, AsyncSnapshot<List<Plant>> snapshot) {
                  if(!snapshot.hasData) {
                    return Center(child: Text('Loading...'));
                  }
                  return snapshot.data!.isEmpty ? 
                  Center(child: Text('No plants in List.'))
                  : ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.map((plant) {
                      return Center(
                        child: ListTile(
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
                        ),
                      );
                    }).toList(), //TODO: 
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: remove, qui non c'entra niente
  void getPlants2() async {
    List<Plant> _plants2 = await DatabaseHelper.instance.getPlants(); //TODO: uncomment rinominare in _plants 
    print('_plants2 dal database: ${_plants2.toString()}');
    print('_plants2[0]: ${_plants2[0].toString()}');
    inspect(_plants2); //TODO: remove
  }

  void deleteAllPlantsFromDB() async {
    int listSize = (await DatabaseHelper.instance.getPlants()).length;
    print('listSize: ${listSize}');

    for(int i = 0; i <= listSize; i++) {
      await DatabaseHelper.instance.remove(i);
    }
  }
}
