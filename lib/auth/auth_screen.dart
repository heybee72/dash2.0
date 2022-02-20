
import 'package:flutter/material.dart';

import 'login.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}
