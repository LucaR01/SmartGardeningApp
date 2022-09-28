import 'package:flutter/material.dart';
import 'package:flutter_application_prova/constants/constants.dart';
import 'package:flutter_application_prova/provider/theme_provider.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:flutter_application_prova/widgets/FAB/FABWidget.dart';
import 'package:flutter_application_prova/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_prova/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter_application_prova/widgets/drawer/navigation_drawer.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5)),
      boxShadow: [
        BoxShadow( //TODO: comment?
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 1), // cambia la posizione dell'ombra
            ),
      ],
    );
  }

  Expanded getExpanded({required String imageName, required String title, required String subtitle, required Pages page}) {
    return Expanded(
      child: TextButton(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    '${Constants.iconHomeAssetsPath}$imageName',
                    height: 80.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                const SizedBox(height: 5.0,),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ],
            ),
          ),
          margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
          decoration: getBoxDecoration(),
        ),
        onPressed: () { Utils.navigateToPage(context: context, page: page); },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const NavigationDrawerWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FABWidget(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).backgroundColor, //TODO: credo che questo non stia prendendo il colore giusto, ma va bene lo stesso.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getExpanded(imageName:'1034358_eco_friendly_ecology_nature_plant_icon.png', title: AppLocalizations.of(context).my_plants, subtitle: 'Collect plants', page: Pages.myPlants), //TODO: localizations
                  getExpanded(imageName: 'icons8-potted-plant-100.png', title: AppLocalizations.of(context).scan, subtitle: 'Scan your plants', page: Pages.scan), //TODO: localizations
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getExpanded(imageName: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? 'phases-of-plant-withering-blossom-and-wilt-flowers-in-the-pots-vector-dark.png' : 'phases-of-plant-withering-blossom-and-wilt-flowers-in-the-pots-vector.jpg', title: AppLocalizations.of(context).diagnosis, subtitle: 'Diagnose your plants\' health', page: Pages.diagnosis), //TODO: localizations
                  getExpanded(imageName:'planet-earth-9324.png', title: AppLocalizations.of(context).my_sensor, subtitle: 'Collect data from your sensors', page: Pages.sensors), //TODO: localizations
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //getExpanded(imageName:'1034358_eco_friendly_ecology_nature_plant_icon.png', title: '', subtitle: '29 Place'), //TODO: volendo il privacy policy, ma non ha molto senso
                  getExpanded(imageName: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? 'plant_settings_icon_dark.png' : 'plant_settings_icon.png', title: AppLocalizations.of(context).settings, subtitle: 'Modify the app\'s settings', page: Pages.settings), //TODO: localizations
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
