import 'package:dash_rider/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Constants.reddish),
    ),
  );
}