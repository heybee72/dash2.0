import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  // const Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            spreadRadius: 0.10,
            offset: Offset(0.7, 0.7),
          ),
        ],
      ),
      child: Divider(
        height: 1,
        color: Colors.blueGrey,
        thickness: 1.0,
      ),
    );
  }
}
