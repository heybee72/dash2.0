import 'package:dash_user_app/screens/innerScreens/stores_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  // getCurrentLocation()async{
  //   Position newPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stores(),
    );
  }
}
