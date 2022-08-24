import 'package:flutter/material.dart';
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
            Flexible( //TODO: ListView?, SingleChildScrollView?
              child: PlantsList(),
            ),
          ],
        ),
      ),
    );
  }
}
