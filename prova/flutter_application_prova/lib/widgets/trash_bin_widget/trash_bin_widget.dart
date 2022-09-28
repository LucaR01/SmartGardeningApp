import 'package:flutter/material.dart';
import 'package:flutter_application_prova/models/database/database_helper.dart';
import 'package:flutter_application_prova/models/plant/plant.dart';

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

  Future openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Remove element'), //TODO: localizations
      titleTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      content: Text('Do you really want to remove plant ${widget.plant.displayPid}'), //TODO: localizations
      contentTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      actions: [
        TextButton(onPressed: () { print('removed element ${widget.plant.id}'); DatabaseHelper.instance.remove(widget.plant.id!); Navigator.of(context).pop(); }, child: Text('Yes')), //TODO: localizations
        TextButton(onPressed: () { Navigator.of(context).pop(); }, child: Text('No')), //TODO: localizations
      ],
    ),
  );
}