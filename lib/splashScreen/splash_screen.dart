import 'dart:async';

import 'package:dash_user2/screens/auth/auth_stream.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    Timer(Duration(seconds: 4), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthStateScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/dash_logo_dark.png'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
