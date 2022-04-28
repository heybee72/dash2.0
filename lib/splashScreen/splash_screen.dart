import 'dart:async';

import 'package:dash_store/auth/auth_screen.dart';
import 'package:dash_store/global/global.dart';
import 'package:dash_store/screens/home_screen.dart';
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
      if (firebaseAuth.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen()),
        );
      }
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
              Image.asset('assets/dash_logo_dark.png', width: 200),
              SizedBox(height: 120),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  'Welcome to Dash Store',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
