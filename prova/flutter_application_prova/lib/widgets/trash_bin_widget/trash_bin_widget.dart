import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/snackbar_messages/custom_snackbar_message.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';
import 'package:flutter_application_prova/constants/constants.dart';
import 'package:flutter_application_prova/models/database/database_helper.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrashBinWidget extends StatefulWidget {
  const TrashBinWidget({ Key? key, required this.plant }) : super(key: key);

  final Plant plant;

  @override
  State<TrashBinWidget> createState() => _TrashBinWidgetState();
}

class _TrashBinWidgetState extends State<TrashBinWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete), 
      onPressed: () { openDialog(); /*DatabaseHelper.instance.remove(widget.plant.id!);*/ },
    );
  }

  /// It shows a [AlertDialog] with 'yes' or 'no' buttons.
  /// If 'yes' is clicked, then a [widget.plant] is removed from the database [DatabaseHelper.instance] and then exits the dialog.
  /// If 'no' is clicked, then it just pops from the dialog.
  Future openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context).remove_element_from_database_message, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)), 
      titleTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      content: Text('${AppLocalizations.of(context).remove_element_from_database_message_body} ${widget.plant.displayPid}?', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)), 
      contentTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      actions: [
        TextButton(onPressed: () { _deleteItem(); }, child: Text(AppLocalizations.of(context).yes, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color))), 
        TextButton(onPressed: () { Navigator.of(context).pop(); }, child: Text(AppLocalizations.of(context).no, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color))), 
      ],
    ),
  );

  _deleteItem() {
    print('removed element: ${widget.plant.id}'); //TODO: just for testing
    dynamic operationResult = DatabaseHelper.instance.remove( widget.plant.id != null ? widget.plant.id! : 0);
    setState(() {}); 
    operationResult != Constants.statusFAIL ? SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).success, msg: AppLocalizations.of(context).element_removed, errorCode: ErrorCodes.success) : SnackBarMessageWidget.snackBarMessage(context: context, title: AppLocalizations.of(context).error, msg: AppLocalizations.of(context).element_not_removed, errorCode: ErrorCodes.error);
    Navigator.of(context).pop();
  }
}