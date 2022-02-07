import 'package:dash_user2/screens/auth/register_screen.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:dash_user2/utils/custom_sized_box.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class ChoosePath extends StatelessWidget {
  static const routeName = 'landing_page';
  const ChoosePath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Image.asset(
                  'assets/dash_logo_dark.png',
                  width: 300,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 60.0, right: 60.0, top: 20, bottom: 110),
                child: Text(
                  "Have food, drinks, groceries and more delivered fast",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Constants.grey_color,
                    fontFamily: 'EuclidCircularB',
                  ),
                ),
              ),
            ),
            Container(
              height: 52.0,
              margin: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 16.0, bottom: 8.0),
              width: size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Constants.secondary_color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'EuclidCircularB',
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
              ),
            ),
            Container(
              height: 52.0,
              margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              width: size.width,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Constants.secondary_color,
                  side:
                      BorderSide(width: 1.0, color: Constants.secondary_color),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 17,
                    color: Constants.secondary_color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'EuclidCircularB',
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterScreen.routeName);
                },
              ),
            ),
            CustomSizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 18.0, right: 8.0),
                    child: Divider(
                      color: Constants.grey_color,
                      thickness: 1.0,
                    ),
                  ),
                ),
                Text(
                  "or",
                  style: TextStyle(
                    fontSize: 14,
                    color: Constants.grey_color,
                    fontFamily: 'EuclidCircularB',
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 8.0, right: 18.0),
                    child: Divider(
                      color: Constants.grey_color,
                      thickness: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 52.0,
              margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              width: size.width,
              child: Center(
                child: InkWell(
                  child: Text(
                    "Continue as Guest",
                    style: TextStyle(
                      fontSize: 15,
                      color: Constants.grey_color,
                      fontFamily: 'EuclidCircularB',
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) {
                    //   return LoginScreen();
                    // }));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
