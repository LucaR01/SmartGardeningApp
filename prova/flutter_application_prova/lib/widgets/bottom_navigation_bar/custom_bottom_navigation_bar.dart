import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../screens/pages.dart';
import '../../utils/utils.dart';

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
      backgroundColor: Colors.green, //TODO: usare le theme color
      selectedItemColor: Colors.white, //TODO: usare le theme color
      unselectedItemColor: Colors.white70, //TODO: usare le theme color
      iconSize: 30, //TODO: update
      //selectedFontSize: 22, //TODO: remove
      //unselectedFontSize: 18, //TODO: remove
      //showUnselectedLabels: false, //TODO: remove

      items: const [
        BottomNavigationBarItem( //TODO: usare una funzione chiamata buildBottomNavigationBarItem() ?
          icon: Icon(FontAwesomeIcons.seedling),
          label: 'My Plants',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sensors),
          label: 'Sensors', //TODO: usare Localizations
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.stethoscope),
          label: 'Diagnosis',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
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