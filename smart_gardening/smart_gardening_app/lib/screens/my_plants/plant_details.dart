import 'package:flutter/material.dart';

import 'package:smart_gardening_app/models/plant/plant.dart';
import 'package:smart_gardening_app/widgets/app_bar/app_bar.dart';
import 'package:smart_gardening_app/widgets/trash_bin_widget/trash_bin_widget.dart';

import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlantDetails extends StatelessWidget {
  const PlantDetails({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: const AppBarWidget(),
      extendBodyBehindAppBar: true,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              ClipRect(
                child: Image.file(
                  File(plant.imageUrl),
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                title: Text(
                  plant.displayPid,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1!.color, 
                  ),
                ),
                subtitle: Text(
                  '${AppLocalizations.of(context).confidence}: ${(plant.accuracy * 100.0).toString()}%',
                  style: TextStyle(
                    letterSpacing: 0.9,
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyText1!.color, 
                  ),
                ),
                trailing: TrashBinWidget(plant: plant), // prima c'era il Icons.favorite
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      //Icon(Icons.water),
                      Text(
                        '${AppLocalizations.of(context).max_light_mmol}: ${plant.maxLightMmol.toString()}, ${AppLocalizations.of(context).max_light_lux}: ${plant.maxLightLux.toString()}', 
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                        ),
                      ),
                      //Icon(Icons.sunny),
                      Text(
                        '${AppLocalizations.of(context).min_light_mmol}: ${plant.minLightMmol.toString()}, ${AppLocalizations.of(context).min_light_lux}: ${plant.minLightLux.toString()}',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '${AppLocalizations.of(context).max_temp}: ${plant.maxTemp.toString()}, ${AppLocalizations.of(context).min_temp}: ${plant.minTemp.toString()}', 
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                        ),
                      ),
                      Text(
                        '${AppLocalizations.of(context).min_env_humid}: ${plant.minEnvHumid.toString()}, ${AppLocalizations.of(context).max_env_humid}: ${plant.maxEnvHumid.toString()}',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '${AppLocalizations.of(context).min_soil_moist}: ${plant.minSoilMoist}, ${AppLocalizations.of(context).max_soil_moist}: ${plant.maxSoilMoist}', 
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, 
                        ),
                      ),
                      Text(
                        '${AppLocalizations.of(context).min_soil_ec}: ${plant.minSoilEC.toString()}, ${AppLocalizations.of(context).max_soil_ec}: ${plant.maxSoilEC.toString()} ${AppLocalizations.of(context).ec}',
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