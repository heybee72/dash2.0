import 'package:dash_store/utils/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObscure = false;
  bool? enabled = true;
  final TextInputType? inputType;

  CustomTextField(
      {Key? key,
      this.controller,
      this.data,
      this.hintText,
      this.isObscure,
      this.enabled,
      this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure ?? false,
        enabled: enabled,
        cursorColor: Constants.primary_color,
        textInputAction: TextInputAction.next,
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(data, size: 16, color: Constants.primary_color),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0XFF777777), fontSize: 14.0),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Constants.secondary_color, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
