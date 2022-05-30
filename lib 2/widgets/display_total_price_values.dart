import 'dart:io';

import 'package:flutter/material.dart';

class DisplayValue extends StatelessWidget {
  final String? amt;
  final Color? color;
  final FontWeight? fWeight;
  const DisplayValue({
    Key? key,
    this.amt,
    this.color,
    this.fWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "₦",
            style: TextStyle(
                fontFamily: Platform.isAndroid ? 'Roboto' : '',
                fontWeight: fWeight,
                fontSize: 15.0,
                color: color),
          ),
          TextSpan(
            text: "${amt}",
            style: TextStyle(
                fontSize: 15.0, fontWeight: FontWeight.w600, color: color),
          )
        ],
      ),
    );
  }
}