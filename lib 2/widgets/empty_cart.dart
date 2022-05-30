import 'package:dash_user_app/screens/bottom_nav_screen.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 120),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/emptycart.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            "Your Basket is Empty",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Looks Like you Didn't \n Add Anything to your Basket",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 40),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Constants.secondary_color,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(BottomNavScreen.routeName);
              },
              child: Text(
                "Back Home",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
