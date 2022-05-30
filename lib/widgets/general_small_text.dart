import 'package:flutter/material.dart';

class GeneralSmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  GeneralSmallText({
    Key? key,
    this.color = const Color(0xffccc7c5),
    required this.text,
    this.size = 14,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textFinal = "";
    if (text.length > 80) {
      textFinal = text.substring(0, 80) + "...";
    } else {
      textFinal = text;
    }

    return Text(
      textFinal,
      style: TextStyle(
        fontSize: size,
        color: color,
        height: height,
      ),
    );
  }
}
