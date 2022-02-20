
import 'package:dash_store/global/global.dart';
import 'package:dash_store/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splashScreen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dash Store',
      debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'EuclidCircularB',
            primaryColor: Constants.primary_color,
            buttonTheme: ButtonThemeData(
              buttonColor: Constants.secondary_color,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
      home: MySplashScreen(),
    );
  }
}
