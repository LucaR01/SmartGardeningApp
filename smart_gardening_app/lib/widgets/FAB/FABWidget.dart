import 'package:flutter/material.dart';

import '../../screens/pages.dart';
import '../../utils/utils.dart';

class FABWidget extends StatelessWidget {
  const FABWidget({Key? key}) : super(key: key); //TODO: volendo aggiungere icon come parametro

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){}, //TODO: Utils.selectedItem(context, Pages.home)
      child: const Icon(Icons.home),
    );
  }
}