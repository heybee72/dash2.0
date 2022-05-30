import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/custom_sized_box.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatefulWidget {
  NoInternet({Key? key}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                ),
                Container(
                  width: 160,
                  child: Image.asset("assets/wifi.png"),
                ),
                CustomSizedBox(height: 34),
                Text(
                  'No orders yet.',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  'Hit the green button below to start ordering',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Start ordering'),
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
          ),
        ),
      ),
    );
  }
}
