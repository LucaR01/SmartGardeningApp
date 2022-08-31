import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';
import 'package:flutter_application_prova/models/database/database_helper.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';

//TODO: modificare i Text()

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
      appBar: AppBarWidget(),
      floatingActionButton: FloatingActionButton( //TODO: usare uno SpeedDial Menu?
        child: const Icon(Icons.add),
        onPressed: () => _addToMyPlants(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "<Nome Pianta> ${widget.plant.displayPid}", //TODO: 
                        style:TextStyle(fontSize: 28),
                      ),
                      Text(
                          "<tipo pianta> ${widget.plant.displayPid}",
                        style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left:10),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top:10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Tipo Pianta", style: TextStyle(fontSize: 18, color: Colors.grey.shade600),),
                                      Text("<tipo_pianta> ${widget.plant.maxLightMmol}", style: TextStyle(fontSize: 24)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top:10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Genere", style: TextStyle(fontSize: 16, color: Colors.grey.shade700),),
                                      Text("<Genere> ${widget.plant.maxLightLux}", style: TextStyle(fontSize: 24)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top:10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Tipo Pianta", style: TextStyle(fontSize: 16, color: Colors.grey.shade700),),
                                      Text("<tipo pianta> ${widget.plant.minEnvHumid}", style: TextStyle(fontSize: 24)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Famiglia", style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                                      Text("<famiglia della pianta> ${widget.plant.maxTemp}", style: TextStyle(fontSize: 24),),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Classe", style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                                      Text("<classe della pianta> ${widget.plant.minSoilMoist}", style: TextStyle(fontSize: 24),),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Tempo di Fioritura", style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                                      Text("<Tempo di Fioritura> ${widget.plant.minSoilEC}", style: TextStyle(fontSize: 24),),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Ciclo di vita", style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                                      Text("<Ciclo di vita>", style: TextStyle(fontSize: 24),),
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
                              /*child: Image( //TODO: remove
                                image: Image.network(widget.plant.imageUrl), //TODO: Image.network(widget.plant.imageUrl); AssetImage("assets/images/scan/${widget.plant.imageUrl}")
                                height: 436, width: 220,
                              ),*/
                              child: Image.network(
                                widget.plant.imageUrl, 
                                height: 436, 
                                width: 220
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Descrizione", style: TextStyle(fontSize: 24),),
                          Container(
                            width: 125,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Divider(
                              height: 5, thickness: 5,
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              style: TextStyle(color: Colors.black54),
                              text: "<Descrizione0> "
                                  "<Descrizione1> "
                                  "<Descrizione2> "
                                  "<Descrizione3> "
                                  "<Descrizione4>",
                            )
                          ],
                        ),
                      )
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
  
  void _addToMyPlants() async {
    final int operationStatusCode = await DatabaseHelper.instance.add(widget.plant);
    print('operationStatusCode: ${operationStatusCode}');

    //TODO: Tradurre title e msg
    //TODO: al posto di operationStatusCode == 0, meglio operationStatusCode == SUCCESS o OK o OKAY
    //TODO: in realtà qui 0 è ERRORE
    operationStatusCode != 0 ? SnackBarMessageWidget.snackBarMessage(context: context, title: 'Success', msg: 'Plant added to MyPlants', errorCode: ErrorCodes.success) : SnackBarMessageWidget.snackBarMessage(context: context, title: 'Error', msg: 'Plant not added', errorCode: ErrorCodes.error);
  }
}