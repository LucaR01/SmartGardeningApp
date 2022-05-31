import 'package:flutter/material.dart';

import '../../screens/home/home_screen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.green[600], //TODO: usare le costanti dei colori.
        child: ListView(
          padding: padding, //TODO: remove?
          children: <Widget>[
            const SizedBox(height: 48),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'My Plants',
              icon: Icons.home, //TODO: update
              //onClicked: () => selectedItem(context, 1), //TODO: uncomment
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Tasks',
              icon: Icons.task,
              //onClicked: () => selectedItem(context, 2), //TODO: uncomment
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Diagnosis',
              icon: Icons.home, //TODO: update
              //onClicked: () => selectedItem(context, 3), //TODO: uncomment
            ),
            const SizedBox(height: 24),
            Divider(color: Colors.white70), //TODO: get color from constants
            const SizedBox(height: 24),

            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              //onClicked: () => selectedItem(context, 4), //TODO: uncomment
            ),

            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Notifications',
              icon: Icons.notifications,
              //onClicked: () => selectedItem(context, 5), //TODO: uncomment
            ),

            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Privacy Policy',
              icon: Icons.privacy_tip
              //onClicked: () => selectedItem(context, 6), //TODO: uncomment
            ),

          ],
        ),
      ),
    );
  }

  //TODO: ne posso fare una che prende anche colore e un hover color
  //TODO: rinominare text in menuName e icon in menuIcon?
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }){
    final color = Colors.white; //TODO: per i colori usare le costanti.
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onClicked,
      );
  }

  void selectedItem(BuildContext context, int index){ //TODO: Usare un enum al posto dell'index intero.
    switch(index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(title: ""), //TODO: remove title
        ));
    }
  }
}