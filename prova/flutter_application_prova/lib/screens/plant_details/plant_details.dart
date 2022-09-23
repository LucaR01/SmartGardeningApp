import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO: mettere questo folder dentro al folder my_plants?

class PlantDetails extends StatelessWidget {
  const PlantDetails({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      appBar: const AppBarWidget(),
      extendBodyBehindAppBar: true,
      body: Container(
        child: SingleChildScrollView(
          child: Column( //TODO: ListView?, SingleChildScrollView?
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              ClipRect(
                /*child: Image.asset(
                  'assets/images/scan/${plant.imageUrl}',
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),*/
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
                    color: Theme.of(context).secondaryHeaderColor, /*TODO: Colors.grey[600],*/ 
                  ),
                ),
                subtitle: Text(
                  '${AppLocalizations.of(context).confidence}: ${(plant.accuracy * 100.0).toString()}%',
                  style: TextStyle(
                    letterSpacing: 0.9,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor, /*TODO: Colors.grey[300],*/ 
                  ),
                ),
                trailing: const Icon(Icons.favorite), //TODO: FavoriteWidget(); update icon to a star
              ),
              Padding(
                padding: const EdgeInsets.all(18), //TODO: symmetric
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      //Icon(Icons.water),
                      Text( //TODO: implementare qualche sorta di grafica/barra //TODO: magari metterlo affianco al titolo e sottotitolo
                        '${AppLocalizations.of(context).max_light_mmol}: ${plant.maxLightMmol.toString()}, ${AppLocalizations.of(context).max_light_lux}: ${plant.maxLightLux.toString()}', //TODO: use strings constants
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color, /*TODO: Colors.grey[200],*/
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
                        '${AppLocalizations.of(context).max_temp}: ${plant.maxTemp.toString()}, ${AppLocalizations.of(context).min_temp}: ${plant.minTemp.toString()}', //TODO: use strings constants
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, /*TODO: Colors.grey[400],*/
                        ),
                      ),
                      Text(
                        '${AppLocalizations.of(context).min_env_humid}: ${plant.minEnvHumid.toString()}, ${AppLocalizations.of(context).max_env_humid}: ${plant.maxEnvHumid.toString()}',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, /*TODO: Colors.grey[300],*/
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '${AppLocalizations.of(context).min_soil_moist}: ${plant.minSoilMoist}, ${AppLocalizations.of(context).max_soil_moist}: ${plant.maxSoilMoist}', //'Altre informazioni',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, /*TODO: Colors.grey[400],*/ 
                        ),
                      ),
                      Text(
                        '${AppLocalizations.of(context).min_soil_ec}: ${plant.minSoilEC.toString()}, ${AppLocalizations.of(context).max_soil_ec}: ${plant.maxSoilEC.toString()} ${AppLocalizations.of(context).ec}',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText2!.color, /*TODO: Colors.grey[300],*/
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