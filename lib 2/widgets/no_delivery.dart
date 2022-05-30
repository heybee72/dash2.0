import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/custom_sized_box.dart';
import 'package:flutter/material.dart';

class NoDelivery extends StatefulWidget {
  NoDelivery({Key? key}) : super(key: key);

  @override
  _NoDeliveryState createState() => _NoDeliveryState();
}

class _NoDeliveryState extends State<NoDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(73.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        //   title: Padding(
        //     padding: const EdgeInsets.only(top: 40, bottom: 13),
        //     child: Row(
        //       children: [
        //         Text(
        //           'Zamfara',
        //           style:
        //               TextStyle(color: Constants.primary_color, fontSize: 15),
        //         ),
        //         Icon(Icons.keyboard_arrow_down, color: Constants.primary_color),
        //       ],
        //     ),
        //   ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  child: Image.asset("assets/grey_big_location_pin.png"),
                ),
                CustomSizedBox(height: 34),
                Text(
                  'Oops!  we don’t deliver here yet.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'We’re expanding fast and will get here soon!',
                  style: TextStyle(
                    fontSize: 15,
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
