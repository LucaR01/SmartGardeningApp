import 'package:flutter/material.dart';
import 'package:flutter_application_prova/api/snackbar_messages/error_codes.dart';
import 'package:flutter_application_prova/constants/colors_constants.dart';

class SnackBarMessageWidget {
  static snackBarMessage({
    required BuildContext context,
    required String title,
    required String msg,
    required ErrorCodes errorCode,
    }) {
    IconData icon = errorCode == ErrorCodes.success ? Icons.check_circle : Icons.error_outline;
    Color? backgroundColor = errorCode == ErrorCodes.success ? ColorConstants.snackBarSuccessMessage : ColorConstants.snackBarErrorMessage;

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 80,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 40,
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title, 
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      msg,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
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