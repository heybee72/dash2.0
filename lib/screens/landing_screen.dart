import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/custom_sized_box.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  static const String routeName = 'landing-screen';
  LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/dash_logo_dark.png"),
      ),
    );
  }
}
