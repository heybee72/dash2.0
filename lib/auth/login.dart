import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_rider/auth/auth_screen.dart';
import 'package:dash_rider/global/global.dart';
import 'package:dash_rider/screens/home_screen.dart';
import 'package:dash_rider/utils/constants.dart';
import 'package:dash_rider/widgets/custom_text_field.dart';
import 'package:dash_rider/widgets/error_dialog.dart';
import 'package:dash_rider/widgets/loading_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'register.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _loading = false;

  formValidation() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // login
      loginNow();
    } else {
      // empty, return null
      showDialog(
        context: context,
        builder: (e) {
          return ErrorDialog(
            message: 'Please fill all the fields',
          );
        },
      );
    }
  }

  loginNow() async {
    showDialog(
      context: context,
      builder: (e) {
        return LoadingDialog(
          message: 'Checking Credentials ',
        );
      },
    );
    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user!;
    }).catchError(
      (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (e) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          },
        );
      },
    );
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("riders")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString('uid', currentUser.uid);
        await sharedPreferences!
            .setString('email', snapshot.data()!['riderEmail']);
        await sharedPreferences!
            .setString('name', snapshot.data()!['riderName']);
        await sharedPreferences!
            .setString('photoUrl', snapshot.data()!['selfieImageUrl']);
        await sharedPreferences!
            .setString('phone', snapshot.data()!['riderPhone']);
        await sharedPreferences!
            .setString('address', snapshot.data()!['address']);
        await sharedPreferences!
            .setString('mot', snapshot.data()!['modeOfTransportation']);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => HomeScreen()));
      } else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => AuthScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Image.asset('assets/dash_logo_dark.png', width: 200.0),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Rider Login",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Constants.primary_color),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    data: Icons.email,
                    inputType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter your Password',
                    data: Icons.password,
                    inputType: TextInputType.text,
                    isObscure: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context)
                          //     .pushNamed(ForgotPasswordScreen.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Constants.grey_color,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              height: 52.0,
              margin: EdgeInsets.only(top: 26.0, bottom: 8.0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Constants.secondary_color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: _loading
                    ? CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'EuclidCircularB',
                        ),
                      ),
                onPressed: () {
                  formValidation();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 60.0,
                top: 20.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0XFF777777),
                        fontFamily: 'EuclidCircularB'),
                    children: [
                      TextSpan(text: 'Don\'t have an account? '),
                      TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                              color: Constants.secondary_color,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
