import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/sensor_api/sensor_api.dart';
import 'package:flutter_application_prova/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';
import 'package:flutter_application_prova/models/aircare_sensor/aircare_sensor.dart';
import 'package:flutter_application_prova/models/aircare_sensor/health_index.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  AppLocalizations.of(context).my_sensor,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColorDark, //TODO: green[900]
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
                        AppLocalizations.of(context).device_id,
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
                  print('_textController.text: ${_textController.text}'); //TODO: remove

                  //airCareSensor = await SensorAPI.getAirCareSensorData(deviceId: _textController.text); //TODO: remove

                  _textController.text.isNotEmpty ? airCareSensor = await SensorAPI.getAirCareSensorData(deviceId: _textController.text) : SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).empty_field, msg: '${AppLocalizations.of(context).insert} ${AppLocalizations.of(context).device_id}', errorCode: ErrorCodes.error);

                  airCareSensor != null ? SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).success, msg: '${AppLocalizations.of(context).aircare_sensor} ${AppLocalizations.of(context).data_retrieved}', errorCode: ErrorCodes.success) : SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).failed, msg: '${AppLocalizations.of(context).aircare_sensor} ${AppLocalizations.of(context).data_not_retrieved}', errorCode: ErrorCodes.error);

                  // setState mi serve, anche se vuota, non c'è bisogno del airCareSensor, basta solo setState, così mi aggiorna la build!
                  setState(() {
                    //_textController.text.isNotEmpty ? airCareSensor = (await SensorAPI.getAirCareSensorData(deviceId: _textController.text))! : print('è vuota!'); //TODO: remove
                    airCareSensor;
                  });
                },
                child: Text(AppLocalizations.of(context).get_device_data),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ListTile(
                title: Text(
                  airCareSensor != null ? airCareSensor!.timeUtc.toString() : '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).secondaryHeaderColor, /*TODO: Colors.grey[600]*/ 
                  ),
                ),
                subtitle: Text(
                  '${AppLocalizations.of(context).temperature}: ${airCareSensor?.temperature}', 
                  style: TextStyle(
                    letterSpacing: 0.9,
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyText2!.color, /*TODO: Colors.grey[300],*/
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
                        '${AppLocalizations.of(context).co2}: ${airCareSensor?.co2 ?? ''}, ${AppLocalizations.of(context).humidity}: ${airCareSensor?.humidity}', 
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color, //TODO: grey[200]
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
                        '${AppLocalizations.of(context).min_temp}: ${airCareSensor?.minTemp} ${AppLocalizations.of(context).max_temp}: ${airCareSensor?.maxTemp}', 
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, /*TODO: Colors.grey[400]*/
                        ),
                      ),
                      Text(
                        airCareSensor?.noise.toString() ?? '',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, //TODO: grey[300]
                          fontSize: 14,
                        ),
                      ),
                      //SizedBox(height: 30),
                      Text(
                        '${AppLocalizations.of(context).health_index}: ${airCareSensor?.healthIndex.name.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, //TODO: grey[400]
                        ),
                      ),
                      Text(
                        '${AppLocalizations.of(context).pressure}: ${airCareSensor?.pressure.toString()}',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, //TODO: grey[300]
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${AppLocalizations.of(context).absolute_pressure}: ${airCareSensor?.absolutePressure}',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, //TODO: grey[300]
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      Text(
                        '${AppLocalizations.of(context).date_max_temp}: ${airCareSensor?.dateMaxTemp}',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, //TODO: grey[300]
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${AppLocalizations.of(context).date_min_temp}: ${airCareSensor?.dateMinTemp}',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, //TODO: grey[300]
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /*FutureBuilder<List<>>( //TODO: remove?
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
