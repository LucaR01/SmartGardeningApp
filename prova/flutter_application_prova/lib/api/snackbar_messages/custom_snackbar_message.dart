import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';

//TODO: Icons.error_outline

class CustomSnackBarMessage extends StatefulWidget {
  const CustomSnackBarMessage({ Key? key }) : super(key: key);

  @override
  State<CustomSnackBarMessage> createState() => _CustomSnackBarMessageState();
}

class _CustomSnackBarMessageState extends State<CustomSnackBarMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () => {
            SnackBarMessageWidget.SnackBarMessage(context: context, title: "Flutter Title", msg: "Message of the snackbar", errorCode: ErrorCodes.success),
          },
          child: Text("Click to Show Message"),
        ),
      ),
    );
  }

  _SnackBarMessage({
    required BuildContext context,
    required String title,
    required String msg,
    required ErrorCodes errorCode,
    }) {
    IconData icon = errorCode == ErrorCodes.success ? Icons.check_circle : Icons.error_outline;
    Color? backgroundColor = errorCode == ErrorCodes.success ? Colors.green[700] : Colors.red[700];

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.all(8),
          height: 80,
          decoration: BoxDecoration(
            color: backgroundColor, //TODO: use color constants
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(
                icon, //Icons.check_circle, 
                color: Colors.white, 
                size: 40,
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title, 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white, //TODO: use color constants or theme data
                      ),
                    ),
                    Spacer(),
                    Text(
                      msg,
                      style: TextStyle(
                        color: Colors.white, //TODO: use color constants or theme data
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 3,
      ),
    );
  }
}

class SnackBarMessageWidget {
  static SnackBarMessage({
    required BuildContext context,
    required String title,
    required String msg,
    required ErrorCodes errorCode,
    }) {
    IconData icon = errorCode == ErrorCodes.success ? Icons.check_circle : Icons.error_outline;
    Color? backgroundColor = errorCode == ErrorCodes.success ? Colors.green[700] : Colors.red[700];

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.all(8),
          height: 80,
          decoration: BoxDecoration(
            color: backgroundColor, //TODO: use color constants
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(
                icon, //Icons.check_circle, 
                color: Colors.white, 
                size: 40,
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title, 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white, //TODO: use color constants or theme data
                      ),
                    ),
                    Spacer(),
                    Text(
                      msg,
                      style: TextStyle(
                        color: Colors.white, //TODO: use color constants or theme data
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 3,
      ),
    );
  }
}