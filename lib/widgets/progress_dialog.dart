import 'package:flutter/material.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class ProgressDialog extends StatefulWidget {
  ProgressDialog({Key? key, required this.message}) : super(key: key);

  String message;

  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Constants.primary_color,
      child: Container(
        margin: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 6,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
              ),
              SizedBox(
                width: 26,
              ),
              Text(
                widget.message,
                style: TextStyle(color: Colors.black, fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
