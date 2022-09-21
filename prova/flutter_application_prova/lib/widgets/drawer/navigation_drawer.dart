import 'package:flutter/material.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO: rinominare in CustomNavigationDrawerWidget?

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).navigationBarTheme.backgroundColor, //TODO: green[600]
        child: ListView(
          padding: padding, //TODO: remove?
          children: <Widget>[
            buildHeader(), //TODO: image: img,

            //TODO: volendo aggiungere container con column
            const SizedBox(height: 48),
            buildMenuItem(
              text: AppLocalizations.of(context).home,
              icon: Icons.home,
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.home, shouldPop: true),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: AppLocalizations.of(context).my_plants,
              icon: FontAwesomeIcons.seedling, 
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.myPlants, shouldPop: true),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: AppLocalizations.of(context).my_sensor,
              icon: Icons.sensors,
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.sensors, shouldPop: true),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: AppLocalizations.of(context).diagnosis,
              icon: FontAwesomeIcons.stethoscope, 
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.diagnosis, shouldPop: true), 
            ),
            const SizedBox(height: 24),
            Divider(color: Theme.of(context).dividerColor), //TODO: white70
            //const SizedBox(height: 24),

            const SizedBox(height: 16),
            buildMenuItem(
              text: AppLocalizations.of(context).settings,
              icon: Icons.settings,
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.settings, shouldPop: true), //TODO: uncomment
            ),

            /*const SizedBox(height: 16), //TODO: remove?
            buildMenuItem(
              text: AppLocalizations.of(context).notifications,
              icon: Icons.notifications,
              //onClicked: () => Utils.navigateToPage(context: context, page: Pages.home, shouldPop: true), //TODO: uncomment
            ),*/

            /*const SizedBox(height: 24), //TODO: remove?
            Divider(color: Theme.of(context).dividerColor), //TODO: white70
            const SizedBox(height: 24),*/

            const SizedBox(height: 16),
            buildMenuItem(text: AppLocalizations.of(context).privacy_policy, icon: Icons.privacy_tip
                //onClicked: () => Utils.navigateToPage(context: context, page: Pages.home, shouldPop: true), //TODO: uncomment
                ),
          ],
        ),
      ),
    );
  }

  //TODO: required Image image?
  //TODO: remove?
  Widget buildHeader({VoidCallback? onClicked}) => InkWell(
        onTap: onClicked,
        child: Container(
          child: Row(
            children: [
              //CircleAvatar(radius: 30, backgroundImage: Image()), //TODO: add plant image.
            ],
          ),
        ),
      );

  //TODO: ne posso fare una che prende anche colore e un hover color
  //TODO: rinominare text in menuName e icon in menuIcon?
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white; //TODO: per i colori usare le costanti.
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onClicked,
    );
  }
}
