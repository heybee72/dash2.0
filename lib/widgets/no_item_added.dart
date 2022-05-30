import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/dimensions.dart';
import 'package:flutter/material.dart';

class NoItemAdded extends StatefulWidget {
  NoItemAdded({Key? key}) : super(key: key);

  @override
  _NoItemAddedState createState() => _NoItemAddedState();
}

class _NoItemAddedState extends State<NoItemAdded> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Dimensions.height45 *2,
            ),
            Container(
              width: 160,
              child: Image.asset("assets/grey_cart.png"),
            ),
            SizedBox(height: 34),
            Text(
              'No Item Added Yet.',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
