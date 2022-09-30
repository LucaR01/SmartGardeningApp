import 'package:flutter/material.dart';
import 'package:smart_gardening_app/constants/constants.dart';
import 'package:smart_gardening_app/screens/pages.dart';
import 'package:smart_gardening_app/utils/utils.dart';
import 'package:smart_gardening_app/widgets/language_picker/language_picker.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, this.title = Constants.appName, /*this.hasIcons = true*/}) : super(key: key);

  final String title;
  //final bool hasIcons; 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).accentIconTheme, 
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0.0,
      title: Text(title),
      titleTextStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyText1!.color, 
        fontSize: 36, 
      ),
      actions: [
        const LanguagePickerWidget(),
        const SizedBox(width: 12), 
        /*IconButton( 
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),*/
        IconButton(
          icon: const Icon(Icons.camera),
          onPressed: () => Utils.navigateToPage(context: context, page: Pages.scan),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}