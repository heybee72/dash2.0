import 'package:dash_store/auth/auth_screen.dart';
import 'package:dash_store/global/global.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            sharedPreferences!.getString('name')!,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            firebaseAuth.signOut().then((value) {
              sharedPreferences!.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthScreen(),
                ),
              );
            });
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
