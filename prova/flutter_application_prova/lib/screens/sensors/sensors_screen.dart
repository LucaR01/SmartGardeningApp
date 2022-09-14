import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/sensor_api/sensor_api.dart';
import 'package:flutter_application_prova/models/aircare_sensor/aircare_sensor.dart';
import 'package:flutter_application_prova/models/aircare_sensor/health_index.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';

//TODO: rename in Sensors?
//TODO: rename in SensorScreen?

//TODO: mettere il pulsante affianco al text field

class SensorPage extends StatefulWidget {
  const SensorPage({Key? key}) : super(key: key);

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  
  final _textController = TextEditingController();
  AirCareSensor? airCareSensor;

  @override
  void initState() {
    super.initState();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: 60,
                child: Text(
                  'My Sensor', //TODO: use localizations
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //const SizedBox(height: 20), //TODO:
              SizedBox(
                width: 200.0,
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                        'device id', //TODO: applocalizations; Netatmo Home Care | Inserire il device Id o il id del device
                    suffixIcon: IconButton(
                      onPressed: () => _textController.clear(), // () {}
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
              //const SizedBox(height: 10.0,), //TODO:
              ElevatedButton(
                onPressed: () async {
                  //TODO: =>
                  print('_textController.text: ${_textController.text}'); //TODO: remove

                  setState(() {
                    //TODO: uncomment
                    //_textController.text.isNotEmpty ? airCareSensor = (await SensorAPI.getAirCareSensorData(deviceId: _textController.text))! : print('è vuota!'); //TODO: nel : mettere {}
                    airCareSensor = AirCareSensor(timeUtc: '1555677739', temperature: 21.2, co2: 967, humidity: 37, noise: 41, pressure: 45, absolutePressure: 1022.9, healthIndex: HealthIndex.values[1], minTemp: 21.2, maxTemp: 27.4, dateMaxTemp: '1555662436', dateMinTemp: '1555631374');; //TODO: remove, just for test
                  });
                },
                child: Text('Get device\'s data'), //TODO: localizations
              ),
              const SizedBox(
                height: 30.0,
              ),
              ListTile(
                title: Text(
                  airCareSensor != null ? airCareSensor!.timeUtc : '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600], //TODO: use color constants
                  ),
                ),
                subtitle: Text(
                  'Temperatura: ${airCareSensor?.temperature}', //TODO: use strings constants
                  style: TextStyle(
                    letterSpacing: 0.9,
                    fontSize: 14,
                    color: Colors.grey[300], //TODO: use color constants
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18), //TODO: symmetric
                /*child: Text(
                  'Descrizione \n ${plant.description}',
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.grey[200], //TODO: use color constants
                  ),
                ),*/
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Icon(Icons.water),
                      Text(
                        //TODO: implementare qualche sorta di grafica/barra //TODO: magari metterlo affianco al titolo e sottotitolo
                        'CO2: ${airCareSensor?.co2 ?? ''}, Humidity: ${airCareSensor?.humidity}', //TODO: use strings constants
                        style: TextStyle(
                          color: Colors.grey[200], //TODO: use color constants
                        ),
                      ),
                      //Icon(Icons.sunny),
                      /*Text(
                        'Sole/giorno: ${plant.sunAmount}', //TODO: use strings constants
                        style: TextStyle(
                          color: Colors.grey[200], //TODO: use color constants
                        ),
                      ),*/
                      //SizedBox(height: 30),
                      Text(
                        'min temp: ${airCareSensor?.minTemp} max temp: ${airCareSensor?.maxTemp}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Colors.grey[400], //TODO: use color constants
                        ),
                      ),
                      Text(
                        airCareSensor?.noise.toString() ?? '',
                        style: TextStyle(
                          height: 1.4,
                          color: Colors.grey[300], //TODO: use color constants
                          fontSize: 14,
                        ),
                      ),
                      //SizedBox(height: 30),
                      Text(
                        'Health Index: ${airCareSensor?.healthIndex.name.toString()}', //TODO: use strings constants
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Colors.grey[400], //TODO: use color constants
                        ),
                      ),
                      Text(
                        'pressure: ${airCareSensor?.pressure.toString()}',
                        style: TextStyle(
                          height: 1.4,
                          color: Colors.grey[300], //TODO: use color constants
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Absolute pressure: ${airCareSensor?.absolutePressure}',
                        style: TextStyle(
                          height: 1.4,
                          color: Colors.grey[300], //TODO: use color constants
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      Text(
                        'date Max Temp: ${airCareSensor?.dateMaxTemp}',
                        style: TextStyle(
                          height: 1.4,
                          color: Colors.grey[300], //TODO: use color constants
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'date Min Temp: ${airCareSensor?.dateMinTemp}',
                        style: TextStyle(
                          height: 1.4,
                          color: Colors.grey[300], //TODO: use color constants
                          fontSize: 14,
                        ),
                      ),
                    ],
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
