import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../screens/home/home_screen.dart';
import '../../screens/pages.dart';
import '../../utils/utils.dart';

//TODO: rinominare in CustomNavigationDrawerWidget?

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
            buildHeader(), //TODO: image: img,

            //TODO: volendo aggiungere container con column
            const SizedBox(height: 48),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home,
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.home),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'My Plants',
              icon: FontAwesomeIcons.seedling, 
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.myPlants),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Tasks',
              icon: Icons.task,
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.tasks),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Diagnosis',
              icon: FontAwesomeIcons.stethoscope, 
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.diagnosis), 
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white70), //TODO: get color from constants
            const SizedBox(height: 24),

            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onClicked: () => Utils.navigateToPage(context: context, page: Pages.settings), //TODO: uncomment
            ),

            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Notifications',
              icon: Icons.notifications,
              //onClicked: () => Utils.navigateToPage(context: context, page: Pages.home), //TODO: uncomment
            ),

            const SizedBox(height: 16),
            buildMenuItem(text: 'Privacy Policy', icon: Icons.privacy_tip
                //onClicked: () => Utils.navigateToPage(context: context, page: Pages.home), //TODO: uncomment
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
    final color = Colors.white; //TODO: per i colori usare le costanti.
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, Pages page) {
    Navigator.of(context).pop(); // Così si chiude il navigation drawer

    switch (page) {
      case Pages.home:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));*/
        Navigator.of(context).pushNamed('/');
        break;
      case Pages.myPlants:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        break;
      case Pages.tasks:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        break;
      case Pages.diagnosis:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        break;
      case Pages.settings:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        break;
      case Pages.notifications:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        break;
      case Pages.privacyPolicy:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        break;
      default:
        //TODO: forse non serve il default.
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => , 
        ));*/ //TODO: uncomment
        break;
    }
  }
}
