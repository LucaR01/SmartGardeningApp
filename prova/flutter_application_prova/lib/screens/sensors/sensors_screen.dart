import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/sensor_api/sensor_api.dart';
import 'package:flutter_application_prova/models/aircare_sensor/aircare_sensor.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';

//TODO: rename in Sensors?
//TODO: rename in SensorScreen?

class SensorPage extends StatefulWidget {
  const SensorPage({Key? key}) : super(key: key);

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {

  @override
  void initState() { //TODO: async
    super.initState();
    //AirCareSensor airCareSensor = (await SensorAPI.getData())!; //TODO: uncomment
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const AppBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //TODO: baseline?
            children: <Widget> [
              const SizedBox(height: 30),
              SizedBox(
                height: 60,
                child: Text(
                  'My Sensor',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              /*FutureBuilder<List<>>( //TODO: fix
                future: DatabaseHelper.instance.getPlants(),
                builder: (BuildContext context, AsyncSnapshot<List<Plant>> snapshot) {
                  if(!snapshot.hasData) {
                    return Center(child: Text('Loading...'));; //Center(child: Text('Loading...')); //TODO: SpinKitCircle() LoadingScreen();
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
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}