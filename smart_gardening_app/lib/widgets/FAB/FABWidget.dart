import 'package:flutter/material.dart';

import '../../screens/pages.dart';
import '../../utils/utils.dart';

//TODO: rinominare in CustomFABWidget?

class FABWidget extends StatelessWidget {
  const FABWidget({Key? key}) : super(key: key); //TODO: volendo aggiungere icon come parametro

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Utils.navigateToPage(context: context, page: Pages.home),
      child: const Icon(Icons.home),
    );
  }
}