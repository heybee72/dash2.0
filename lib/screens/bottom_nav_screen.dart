import 'package:dash_user2/screens/profile_screen.dart';
import 'package:dash_user2/screens/search_screen.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'orders_screen.dart';

class BottomNavScreen extends StatefulWidget {
  static const routeName = '/Bottom-nav-screen';
  BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  List _pages = [
    HomeScreen(),
    SearchScreen(),
    OrdersScreen(index: 0),
    ProfileScreen()
  ];
  int _currentIndex = 0;
  _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Constants.primary_color,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
