import 'package:flutter/material.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO: rename in CustomBottomNavigationBarWidget?
//TODO: update in StatelessWidget?

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
      type: BottomNavigationBarType.fixed, //TODO: remove?
      backgroundColor: Theme.of(context).bottomAppBarColor,
      selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor, //TODO: controllare se il colore va bene
      unselectedItemColor: Theme.of(context).textSelectionTheme.selectionHandleColor, //TODO: controllare se il colore va bene
      iconSize: 30, //TODO: update
      //selectedFontSize: 22, //TODO: remove
      //unselectedFontSize: 18, //TODO: remove
      //showUnselectedLabels: false, //TODO: remove

      items: [
        BottomNavigationBarItem( //TODO: usare una funzione chiamata buildBottomNavigationBarItem() ?
          icon: const Icon(FontAwesomeIcons.seedling),
          label: AppLocalizations.of(context).my_plants,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.sensors),
          label: AppLocalizations.of(context).my_sensor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.stethoscope),
          label: AppLocalizations.of(context).diagnosis,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context).settings,
        ),
      ],
    );
  }

  //TODO: remove?
  BottomNavigationBarItem _buildBottomNavigationBarItem({required Icon icon, required String label}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}