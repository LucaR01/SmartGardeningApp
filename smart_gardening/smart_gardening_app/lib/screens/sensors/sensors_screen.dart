import 'package:flutter/material.dart';
import 'package:smart_gardening_app/api/sensor_api/sensor_api.dart';
import 'package:smart_gardening_app/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:smart_gardening_app/api/snackbar_messages/error_codes.dart';
import 'package:smart_gardening_app/models/aircare_sensor/aircare_sensor.dart';
import 'package:smart_gardening_app/widgets/FAB/FABWidget.dart';
import 'package:smart_gardening_app/widgets/app_bar/app_bar.dart';
import 'package:smart_gardening_app/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: 60,
                child: Text(
                  AppLocalizations.of(context).my_sensor,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColorDark, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText:
                        AppLocalizations.of(context).device_id,
                    suffixIcon: IconButton(
                      onPressed: () => _textController.clear(), // () {}
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon( 
                onPressed: () async {
                  print('_textController.text: ${_textController.text}'); //TODO: remove

                  _textController.text.isNotEmpty ? airCareSensor = await SensorAPI.getAirCareSensorData(deviceId: _textController.text) : SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).empty_field, msg: '${AppLocalizations.of(context).insert} ${AppLocalizations.of(context).device_id}', errorCode: ErrorCodes.error);

                  airCareSensor != null ? SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).success, msg: '${AppLocalizations.of(context).aircare_sensor} ${AppLocalizations.of(context).data_retrieved}', errorCode: ErrorCodes.success) : SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).failed, msg: '${AppLocalizations.of(context).aircare_sensor} ${AppLocalizations.of(context).data_not_retrieved}', errorCode: ErrorCodes.error);

                  // setState mi serve, anche se vuota, non c'è bisogno del airCareSensor, basta solo setState, così mi aggiorna la build!
                  setState(() {
                    airCareSensor;
                  });
                },
                style: Theme.of(context).elevatedButtonTheme.style, 
                icon: Icon(Icons.data_exploration_outlined, color: Theme.of(context).iconTheme.color), 
                label: Text(AppLocalizations.of(context).get_device_data, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
              ),
              const SizedBox(height: 30.0,),
              ListTile(
                title: Text(
                  airCareSensor != null ? '${AppLocalizations.of(context).time_utc}: ${airCareSensor!.timeUtc.toString()}' : '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).secondaryHeaderColor,  
                  ),
                ),
                subtitle: Text(
                  airCareSensor != null ? '${AppLocalizations.of(context).temperature}: ${airCareSensor?.temperature}' : '', 
                  style: TextStyle(
                    letterSpacing: 0.9,
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyText2!.color, 
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18), 
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Icon(Icons.water),
                      Text(
                        airCareSensor != null ? '${AppLocalizations.of(context).co2}: ${airCareSensor!.co2}, ${AppLocalizations.of(context).humidity}: ${airCareSensor!.humidity}' : '', 
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                      //Icon(Icons.sunny),
                      Text(
                        airCareSensor != null ? '${AppLocalizations.of(context).min_temp}: ${airCareSensor!.minTemp} | ${AppLocalizations.of(context).max_temp}: ${airCareSensor!.maxTemp}' : '', 
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                        ),
                      ),
                      Text(
                        airCareSensor?.noise.toString() ?? '',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                          fontSize: 14,
                        ),
                      ),
                      //SizedBox(height: 30),
                      Text(
                        airCareSensor != null ? '${AppLocalizations.of(context).health_index}: ${airCareSensor!.healthIndex.name.toString()}' : '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                        ),
                      ),
                      Text(
                        airCareSensor != null ? '${AppLocalizations.of(context).pressure}: ${airCareSensor!.pressure.toString()}' : '',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        airCareSensor != null ? '${AppLocalizations.of(context).absolute_pressure}: ${airCareSensor!.absolutePressure}' : '',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 30.0,),
                      Text(
                        airCareSensor != null ? '${AppLocalizations.of(context).date_max_temp}: ${airCareSensor!.dateMaxTemp}' : '',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        airCareSensor != null ? '${AppLocalizations.of(context).date_min_temp}: ${airCareSensor!.dateMinTemp}' : '',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
