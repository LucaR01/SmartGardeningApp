import 'package:flutter/material.dart';

import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';

class PlantDetails extends StatelessWidget {
  const PlantDetails({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      appBar: AppBarWidget(),
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
                child: Image.network(
                  plant.imageUrl,
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              SizedBox(height: 30),
              ListTile(
                title: Text(
                  plant.displayPid,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600], //TODO: use color constants
                  ),
                ),
                subtitle: Text(
                  'Famiglia: ${plant.alias}', //TODO: use strings constants
                  style: TextStyle(
                    letterSpacing: 0.9,
                    fontSize: 14,
                    color: Colors.grey[300], //TODO: use color constants
                  ),
                ),
                trailing: Icon(Icons.favorite), //TODO: FavoriteWidget(); update icon to a star
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
                    children: <Widget> [
                      //Icon(Icons.water),
                      Text( //TODO: implementare qualche sorta di grafica/barra //TODO: magari metterlo affianco al titolo e sottotitolo
                        'Acqua/giorno: ${plant.maxSoilMoist.toString()}, Sole/giorno: ${plant.maxLightLux.toString()}', //TODO: use strings constants
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
                      SizedBox(height: 30),
                      Text(
                        'Descrizione', //TODO: use strings constants
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Colors.grey[400], //TODO: use color constants
                        ),
                      ),
                      Text(
                        plant.minTemp.toString(),
                        style: TextStyle(
                          height: 1.4,
                          color: Colors.grey[300], //TODO: use color constants
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Altre informazioni', //TODO: use strings constants
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.4,
                          color: Colors.grey[400], //TODO: use color constants
                        ),
                      ),
                      Text(
                        plant.accuracy.toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}