import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSizedBox extends StatefulWidget {

  double? width;
  double? height;
  CustomSizedBox({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _CustomSizedBoxState createState() => _CustomSizedBoxState();
}

class _CustomSizedBoxState extends State<CustomSizedBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 0,
      width: widget.width ?? 0,
    );
  }
}
