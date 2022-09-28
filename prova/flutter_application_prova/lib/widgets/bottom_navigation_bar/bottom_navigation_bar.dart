import 'package:flutter/material.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;
  /*final screens = [ 
    HomePage(),
    MyPlantsScreen(),
    SensorPage(),
    DiagnosisScreen(),
    SettingsScreen(),
  ];*/

  @override
  Widget build(BuildContext context) {
    /*body: IndexedStack( 
      index: currentIndex, 
      children: screens,
    ),*/
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        (index) => setState(() => currentIndex = index);
        switch(index) {
          case 0:
            Utils.navigateToPage(context: context, page: Pages.myPlants);
            break;
          case 1:
            Utils.navigateToPage(context: context, page: Pages.sensors);
            break;
          case 2:
            Utils.navigateToPage(context: context, page: Pages.diagnosis);
            break;
          case 3:
            Utils.navigateToPage(context: context, page: Pages.settings);
            break;
        }
      },
      type: BottomNavigationBarType.fixed, 
      backgroundColor: Theme.of(context).bottomAppBarColor,
      selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor, 
      unselectedItemColor: Theme.of(context).textSelectionTheme.selectionHandleColor, 
      iconSize: 30, 
      //selectedFontSize: 22, 
      //unselectedFontSize: 18, 
      //showUnselectedLabels: false, 

      items: [
        _buildBottomNavigationBarItem( 
          icon: const Icon(FontAwesomeIcons.seedling),
          label: AppLocalizations.of(context).my_plants,
        ),
        _buildBottomNavigationBarItem(
          icon: const Icon(Icons.sensors),
          label: AppLocalizations.of(context).my_sensor,
        ),
        _buildBottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.stethoscope),
          label: AppLocalizations.of(context).diagnosis,
        ),
        _buildBottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context).settings,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({required Icon icon, required String label}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}