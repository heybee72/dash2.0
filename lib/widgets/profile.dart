import 'package:dash_user2/utils/custom_sized_box.dart';
import 'package:dash_user2/utils/user_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String _uid = '';
  late String _firstname = '';
  late String _lastname = '';
  late String _email = '';
  late String _phone = '';

  void _getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDocs =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    setState(() {
      _firstname = userDocs.get('firstName');
      _lastname = userDocs.get('lastName');
      _email = userDocs.get('email');
      _phone = userDocs.get('phone');
    });
    print("the email");
    print(_email);
  }

  @override
  initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomSizedBox(height: 75),
              CustomSizedBox(height: 16),
              ProfileCard(title: 'First name', subtitle: _firstname),
              CustomSizedBox(height: 16),
              ProfileCard(title: 'Last name', subtitle: _lastname),
              CustomSizedBox(height: 16),
              ProfileCard(title: 'E-mail', subtitle: '$_email'),
              CustomSizedBox(height: 16),
              Card(
                color: Color(0xFFF4F4F4),
                elevation: 0.1,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 0),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    title: Text(
                      "Phone number",
                      style: TextStyle(
                        color: Color(0xFFC4C4C4),
                        fontSize: 13,
                      ),
                    ),
                    subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "$_phone",
                          style: TextStyle(
                              color: Color(0xFFC4C4C4),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  ProfileCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFF4F4F4),
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 0),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListTile(
          title: Text(
            title.toString(),
            style: TextStyle(
              color: Color(0xF7777777),
              fontSize: 13,
            ),
          ),
          subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                subtitle.toString(),
                style: TextStyle(
                    color: Color(0xFF142328),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )),
        ),
      ),
    );
  }
}
