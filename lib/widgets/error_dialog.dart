import 'package:dash_rider/utils/constants.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String? message;
  const ErrorDialog({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(this.message!),
      actions: [
        ElevatedButton(
          child: const Text('OK'),
          style: ElevatedButton.styleFrom(
            primary: Constants.reddish,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
