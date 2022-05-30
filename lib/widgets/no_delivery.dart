import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/custom_sized_box.dart';
import 'package:dash_user_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoDelivery extends StatefulWidget {
  NoDelivery({Key? key}) : super(key: key);
  @override
  _NoDeliveryState createState() => _NoDeliveryState();
}

class _NoDeliveryState extends State<NoDelivery> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: Dimensions.height45 * 3, left: Dimensions.width20, right: Dimensions.width20),
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
    );
  }
}
