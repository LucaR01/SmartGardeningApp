import 'package:flutter/material.dart';

import '../../constants/strings_constants.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: const Text(kAppName), //TODO: spostare il titolo
      titleTextStyle: TextStyle(
        color: Colors.grey[800], //TODO: black?
        fontSize: 36, //TODO: più piccolo?
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: [
        //SizedBox(width: 24), //TODO: remove?
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        /*IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),*/
        IconButton(
          icon: const Icon(Icons.document_scanner), //TODO: update icon
          onPressed: () {},
        ),
      ],
      /*bottom: PreferredSize( //TODO: uncomment
        child: Container(
          color: Colors.green[200], //TODO: transparent o grigino
          /*child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
          ),*/
        ),
        preferredSize: Size.fromHeight(40.0), //TODO: da aggiornare
      ),*/
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}