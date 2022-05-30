
import 'package:dash_user_app/screens/auth/choose_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bottom_nav_screen.dart';

class AuthStateScreen extends StatefulWidget {
  const AuthStateScreen({Key? key}) : super(key: key);

  @override
  _AuthStateScreenState createState() => _AuthStateScreenState();
}

class _AuthStateScreenState extends State<AuthStateScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return BottomNavScreen();
          } else {
            return ChoosePath();
          }
        } else if (snapshot.hasError) {
          return Center(child: Text('An error occurred'));
        }

        return ChoosePath();
      },
    );
  }
}
