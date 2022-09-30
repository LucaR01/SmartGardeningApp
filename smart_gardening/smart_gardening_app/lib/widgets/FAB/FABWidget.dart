import 'package:flutter/material.dart';

import 'package:smart_gardening_app/screens/pages.dart';
import 'package:smart_gardening_app/utils/utils.dart';

class FABWidget extends StatelessWidget {
  const FABWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Utils.navigateToPage(context: context, page: Pages.home),
      child: Icon(Icons.home, color: Theme.of(context).primaryIconTheme.color),
      backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
    );
  }
}