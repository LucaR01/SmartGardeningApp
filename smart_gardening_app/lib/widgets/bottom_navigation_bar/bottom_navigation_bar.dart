import 'package:flutter/material.dart';

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
                icon: Icon(Icons.home), //TODO: update icon
                onPressed: () {},
              ),
              IconButton(
                //TODO: metterlo in una funzione
                icon: Icon(Icons.home), //TODO: update icon
                onPressed: () {},
              ),
              const SizedBox(width: 24),
              IconButton(
                //TODO: metterlo in una funzione
                icon: Icon(Icons.home), //TODO: update icon
                onPressed: () {},
              ),
              IconButton(
                //TODO: metterlo in una funzione
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
  //TODO: fare una funzione per ognuno dei pulsanti.
}
