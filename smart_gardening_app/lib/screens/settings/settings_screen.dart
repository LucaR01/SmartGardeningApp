import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardening_app/widgets/app_bar/app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool isDarkTheme = false;
  bool areNotificationsOn = false;

  onChangeTheme(bool isDark) {
    setState(() {
      isDarkTheme = isDark;
    });
  }

  onChangeNotifications(bool areNotifications) {
    setState(() {
      areNotificationsOn = areNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.settings, //TODO: update icon
                  color: Colors.green[500], //TODO: use color constants
                ),
                SizedBox(width: 10),
                Text(
                  'Impostazioni', //TODO: use string constants
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            _buildOption(context, 'Lingua'), //TODO: use string constants
            _buildSlideOption('Tema', isDarkTheme, onChangeTheme),
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.green[600], //TODO: use color constants
                ),
                SizedBox(height: 10),
                Text(
                  'Notifications', //TODO: use string constants
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            _buildSlideOption('Notifiche', areNotificationsOn, onChangeNotifications),
            SizedBox(height: 50),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'SALVA',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 2.1,
                    color: Colors.black, //TODO: use color constants
                  ),
                ),
              ), //TODO: volendo aggiungere il pulsante 'RESET'
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Option 1'), //TODO: update
                    Text('Option 2'), //TODO: update
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); //TODO: update
                    },
                    child: Text('Close'), //TODO: update
                  ),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500, //TODO:
                color: Colors.grey[600], //TODO: use color constants
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey, //TODO: use color constants
            ),
          ],
        ),
      ),
    );
  }

  //TODO: rename in _buildSlidingOption?
  Padding _buildSlideOption(String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500, //TODO:
              color: Colors.grey[600], //TODO: use color constants
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.green[600], //TODO: use color constants
              trackColor: Colors.grey, //TODO: use color constants
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
