import 'package:dash_user_app/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';

class GlobalMethods {
  Future<void> showDialogue(BuildContext context, VoidCallback callback) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Remove'),
          content: Text('Going Back will remove all Items from Cart'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                callback();
                Navigator.pushNamedAndRemoveUntil(
                    context, BottomNavScreen.routeName, (route) => false);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> authDialog(BuildContext context, String subTitle) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error Occured'),
          content: Text(subTitle),
          actions: <Widget>[
           
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
