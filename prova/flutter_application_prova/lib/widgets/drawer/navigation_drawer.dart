import 'package:flutter/material.dart';
import 'package:flutter_application_prova/constants/constants.dart';
import 'package:flutter_application_prova/screens/pages.dart';
import 'package:flutter_application_prova/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).navigationBarTheme.backgroundColor, 
        child: ListView(
          padding: padding, 
          children: <Widget>[

            const SizedBox(height: 24),
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
              text: AppLocalizations.of(context).scan,
              icon: Icons.camera, 
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.scan, shouldPop: true), 
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: AppLocalizations.of(context).diagnosis,
              icon: FontAwesomeIcons.stethoscope, 
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.diagnosis, shouldPop: true), 
            ),
            const SizedBox(height: 24),
            Divider(color: Theme.of(context).dividerColor), 
            //const SizedBox(height: 24),

            const SizedBox(height: 16),
            buildMenuItem(
              text: AppLocalizations.of(context).settings,
              icon: Icons.settings,
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.settings, shouldPop: true), 
            ),

            /*const SizedBox(height: 16),
            buildMenuItem(
              text: AppLocalizations.of(context).notifications,
              icon: Icons.notifications,
              //onClicked: () => Utils.navigateToPage(context: context, page: Pages.home, shouldPop: true), 
            ),*/

            /*const SizedBox(height: 24), 
            Divider(color: Theme.of(context).dividerColor), 
            const SizedBox(height: 24),*/

            const SizedBox(height: 16),
            buildMenuItem(text: AppLocalizations.of(context).privacy_policy, icon: Icons.privacy_tip,
                onClicked: () => Utils.navigateToPage(context: context, page: Pages.privacyPolicy, shouldPop: true),
            ),

            const SizedBox(height: 16),
            buildMenuItem(text: 'Terms & Conditions', icon: Icons.private_connectivity, //TODO: aggiornare icona, tipo dei documenti
                onClicked: () => Utils.navigateToPage(context: context, page: Pages.termsAndConditions, shouldPop: true), 
            ),

            const SizedBox(height: 60.0),
            Center(
              child: Column(
                children: [
                  Text(Constants.appName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0)), //TODO: use themes
                  Text(Constants.appVersion, style: TextStyle(color: Colors.grey[300], fontSize: 15.0)), //TODO: use themes
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white; //TODO: themes
    const hoverColor = Colors.white70; //TODO: themes

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onClicked,
      hoverColor: hoverColor, //TODO: controllare se va bene
    );
  }
}
