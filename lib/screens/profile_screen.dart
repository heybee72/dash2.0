import 'package:dash_user_app/utils/custom_sized_box.dart';
import 'package:dash_user_app/utils/user_list_tile.dart';
import 'package:dash_user_app/widgets/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/get_phone_number_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future checkAnonymous() async {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // bool? isAnonymous = prefs.getBool('isAnonymous');
      // print("isAnonymous");
      // print(isAnonymous);
      // if (isAnonymous == true && prefs.containsKey('isAnonymous')) {
      //   prefs.setBool('isAnonymous', false);
        

      //   Navigator.of(context).pushNamed(GetPhoneNumberScreen.routeName);
      // } else {
      //   Navigator.of(context).pushNamed(Profile.routeName);
      // }
      User? user = FirebaseAuth.instance.currentUser;
      if (user!.isAnonymous) {
        Navigator.of(context).pushNamed(GetPhoneNumberScreen.routeName);
      }else {
        Navigator.of(context).pushNamed(Profile.routeName);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'Account',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSizedBox(height: 75),
            UserListTile(
              title: 'Profile',
              tIcon: Icons.arrow_forward_ios,
              tIconCallback: () {
                checkAnonymous();
                // Navigator.of(context).pushNamed(Profile.routeName);
              },
              onTap: () {},
            ),
            UserListTile(
              title: 'All Deliveries',
              tIcon: Icons.arrow_forward_ios,
              tIconCallback: () {},
              onTap: () {},
            ),
            UserListTile(
              title: 'About',
              tIcon: Icons.arrow_forward_ios,
              tIconCallback: () {},
              onTap: () {},
            ),
            UserListTile(
              title: 'Help',
              tIcon: Icons.arrow_forward_ios,
              tIconCallback: () {},
              onTap: () {},
            ),
            UserListTile(
              title: 'FAQ',
              tIcon: Icons.arrow_forward_ios,
              tIconCallback: () {},
              onTap: () {},
            ),
            UserListTile(
              title: 'Support',
              tIcon: Icons.arrow_forward_ios,
              tIconCallback: () {},
              onTap: () {},
            ),
            UserListTile(
              title: 'Privacy Policy',
              tIcon: Icons.arrow_forward_ios,
              tIconCallback: () {},
              onTap: () {},
            ),
            UserListTile(
              title: 'Logout',
              tIcon: Icons.power_settings_new,
              tIconCallback: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
