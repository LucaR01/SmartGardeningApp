import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';
import 'package:flutter_application_prova/constants/constants.dart';
import 'package:flutter_application_prova/models/database/database_helper.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';

import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScanResultScreen extends StatefulWidget {
  const ScanResultScreen({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  State<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addToMyPlants(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, 
              crossAxisAlignment: CrossAxisAlignment.stretch, //TODO: prima era start
              children: [

                Container(
                  padding: const EdgeInsets.all(5), // 10
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch, //TODO: prima era start
                    children: [
                      Text(
                        widget.plant.displayPid,
                        style:TextStyle(fontSize: 28, color: Theme.of(context).textTheme.bodyText1!.color),
                      ),
                      Text(
                          "${AppLocalizations.of(context).confidence}: ${widget.plant.accuracy * 100.0}%",
                        style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left:5), //10
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch, //TODO: prima era .start
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top:5, bottom: 5), // entrambi 10
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch, //TODO: prima era .start
                                    children: [
                                      Text("${AppLocalizations.of(context).min_light_mmol} ${widget.plant.minLightMmol} ${AppLocalizations.of(context).mmol}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color),),
                                      Text("${AppLocalizations.of(context).max_light_mmol} ${widget.plant.maxLightMmol} ${AppLocalizations.of(context).mmol}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top:5, bottom: 5), // entrambi 10
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch, //TODO: prima era .start
                                    children: [
                                      Text("${AppLocalizations.of(context).min_light_lux} ${widget.plant.minLightLux}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color),),
                                      Text("${AppLocalizations.of(context).max_light_lux} ${widget.plant.maxLightLux}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top:5, bottom: 5), // entrambi 10
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch, //TODO: prima era .start
                                    children: [
                                      Text("${AppLocalizations.of(context).max_env_humid} ${widget.plant.maxEnvHumid}", style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyText1!.color),),
                                      Text("${AppLocalizations.of(context).min_env_humid} ${widget.plant.minEnvHumid}", style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText1!.color)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10), // 20
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch, //TODO: prima era .start
                                    children: [
                                      Text("${AppLocalizations.of(context).min_temp} ${widget.plant.minTemp}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color)),
                                      Text("${AppLocalizations.of(context).max_temp} ${widget.plant.maxTemp}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color),),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10), // 20
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch, //TODO: prima era .start
                                    children: [
                                      Text("${AppLocalizations.of(context).max_soil_moist} ${widget.plant.maxSoilMoist}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color)),
                                      Text("${AppLocalizations.of(context).min_soil_moist} ${widget.plant.minSoilMoist}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color),),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10), // 20
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch, //TODO: prima era .start
                                    children: [
                                      Text("${AppLocalizations.of(context).max_soil_ec} ${widget.plant.maxSoilEC} ${AppLocalizations.of(context).ec}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color)),
                                      Text("${AppLocalizations.of(context).min_soil_ec} ${widget.plant.minSoilEC} ${AppLocalizations.of(context).ec}", style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1!.color),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              child: Image.file(
                                File(widget.plant.imageUrl), 
                                height: 256, //436
                                width: 196, //220
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  /// If [FloatingActionButton] has been clicked, it adds the [plant] to the [DatabaseHelper.instance]
  /// If the operation has been successful it shows a [SnackBarMessageWidget] with an [ErrorCodes.success]
  /// else it shows a [SnackBarMessageWidget] with an [ErrorCodes.error].
  void _addToMyPlants() async {
    final int operationStatusCode = await DatabaseHelper.instance.add(widget.plant);
    print('operationStatusCode: $operationStatusCode');

    operationStatusCode != Constants.statusFAIL ? SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).success, msg: '${AppLocalizations.of(context).plant_added_to} ${AppLocalizations.of(context).my_plants}', errorCode: ErrorCodes.success) : SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).error, msg: AppLocalizations.of(context).plant_not_added, errorCode: ErrorCodes.error);
  }
}