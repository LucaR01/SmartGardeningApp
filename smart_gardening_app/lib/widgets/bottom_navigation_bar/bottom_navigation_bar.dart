import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../screens/pages.dart';
import '../../utils/utils.dart';

//TODO: rinominare in CustomBottomNavigationBarWidget?
//TODO: usare bottomNavBar item

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).colorScheme.primary, //TODO: usare color constants.
      child: IconTheme(
        data: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary), //TODO: usare color constants
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                //TODO: metterlo in una funzione
                icon: const Icon(FontAwesomeIcons.seedling),
                onPressed: () => Utils.navigateToPage(context: context, page: Pages.myPlants),
              ),
              IconButton(
                //TODO: metterlo in una funzione
                icon: const Icon(Icons.task),
                onPressed: () => Utils.navigateToPage(context: context, page: Pages.tasks),
              ),
              const SizedBox(width: 24),
              IconButton(
                //TODO: metterlo in una funzione
                icon: const Icon(FontAwesomeIcons.stethoscope),
                onPressed: () => Utils.navigateToPage(context: context, page: Pages.diagnosis),
              ),
              IconButton(
                //TODO: metterlo in una funzione
                icon: const Icon(Icons.settings),
                onPressed: () => Utils.navigateToPage(context: context, page: Pages.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //TODO: fare una funzione per ognuno dei pulsanti.
}
