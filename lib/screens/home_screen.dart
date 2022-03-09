import 'package:dash_store/auth/auth_screen.dart';
import 'package:dash_store/global/global.dart';
import 'package:dash_store/screens/upload/view_menu_screen.dart';
import 'package:dash_store/utils/constants.dart';
import 'package:flutter/material.dart';

import 'upload/items_upload_screen.dart';
import 'upload/menu_upload.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return Row(
        children: [
          Text(
            "Morning!",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          Icon(Icons.sunny, color: Colors.yellow, size: 30),
        ],
      );
    }
    if (hour < 17) {
      return Row(
        children: [
          Text(
            "Afternoon!",
            style: TextStyle(color: Color(0XFFb3dbe0), fontSize: 30),
          ),
          Icon(Icons.sunny_snowing, color: Colors.orange, size: 30),
        ],
      );
    }
    return Row(
      children: [
        Text(
          "Evening!",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        Transform.rotate(
            angle: 320,
            child: Icon(Icons.nightlight, color: Color(0XFFFEC051), size: 20)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Good ",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    greeting(),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Welcome to ${sharedPreferences!.getString('name')!}",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Balance",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      // SizedBox(height: 5),
                      Text(
                        "0.00",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Make Withdrawal",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Constants.secondary_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuUploadScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Card(
                          color: Constants.reddish,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Add Item Category",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(Icons.add, color: Colors.white),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewMenuScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          color: Colors.black,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "View ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Icon(Icons.remove_red_eye_rounded,
                                        color: Colors.white, size: 20),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemsUploadScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Card(
                          color: Constants.reddish.withGreen(1),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Add New Item",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(Icons.add, color: Colors.white),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewMenuScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          color: Colors.black.withOpacity(0.5),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "View ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Icon(Icons.remove_red_eye_rounded,
                                        color: Colors.white, size: 20),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      child: Card(
                        color: Colors.black54,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Order History ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.local_shipping,
                                      color: Colors.white),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                "View your order history",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: Card(
                        color: Colors.black54,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "New Orders ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.reorder, color: Colors.white),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                "view new orders",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
