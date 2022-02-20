import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user2/global/global.dart';
import 'package:dash_user2/screens/auth/auth_stream.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_nav_screen.dart';
import 'register_screen.dart';

// ignore: must_be_immutable
class VerifyPhoneNumber extends StatefulWidget {
  static const routeName = '/verify-phone-number';
  String? phoneNumber;
  VerifyPhoneNumber({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _wrongOtp = false;
  bool _resentCode = false;
  var _verificationId;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  TextEditingController pinEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber.toString(),
        codeSent: (verificationId, orceResendingToken) async {
          setState(() {
            this._verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) async {},
        verificationCompleted:
            (PhoneAuthCredential phoneAuthCredential) async {},
        verificationFailed: (FirebaseAuthException error) async {
          if (_wrongOtp == false) {
            setState(() {
              _wrongOtp = true;
            });
          }
        });
  }

  Future _sendCodeToFirebase({String? code}) async {
    if (this._verificationId != null) {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!.toString());
      try {
        User? currentUser;
        await _auth
            .signInWithCredential(credential)
            .then((value) {
              currentUser = value.user!;
              print(value.additionalUserInfo!.isNewUser);
              print(value.user!.uid);
              if (value.additionalUserInfo!.isNewUser) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterScreen(phoneNumber: widget.phoneNumber);
                    },
                  ),
                );
              } else {
                // save user into local storage
                readDataAndSetDataLocally(currentUser!);
              }
            })
            .whenComplete(() {})
            .onError((error, stackTrace) {
              // print(error);
              if (_wrongOtp == false) {
                setState(() {
                  _wrongOtp = true;
                });
              }
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-action-code') {
          print('The code is invalid.');
        }
        if (_wrongOtp == false) {
          setState(() {
            _wrongOtp = true;
          });
        }
      }
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString('uid', currentUser.uid);
        await sharedPreferences!.setString('email', snapshot.data()!['email']);
        await sharedPreferences!
            .setString('firstName', snapshot.data()!['firstName']);
        await sharedPreferences!
            .setString('lastName', snapshot.data()!['lastName']);
        await sharedPreferences!.setString('phone', snapshot.data()!['phone']);
        Navigator.pushNamed(context, BottomNavScreen.routeName);
      } else {
        firebaseAuth.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AuthStateScreen();
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter code',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(height: 40),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                "Please enter the 4-digit code sent to ${widget.phoneNumber}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Constants.grey_color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: PinCodeTextField(
                  controller: pinEditingController,
                  length: 6,
                  onChanged: (String value) {
                    print(value);
                    if (value.length == 6) {
                      // perform the verification

                      _sendCodeToFirebase(code: value);
                    }
                  },
                  onCompleted: (String value) {
                    setState(() {
                      _wrongOtp = false;
                    });

                    // PhoneAuthCredential phoneAuthCredential =
                    //     PhoneAuthProvider.credential(
                    //         verificationId: widget.verificationId,
                    //         smsCode: pinEditingController.text);
                    // signInWithPhone(phoneAuthCredential);
                    // print("credential:: ${phoneAuthCredential.toString()}");
                  },
                  autoFocus: true,
                  keyboardType: TextInputType.phone,
                  backgroundColor: Colors.transparent,
                  autoDisposeControllers: true,
                  enableActiveFill: true,
                  pinTheme: PinTheme(
                      inactiveColor: Colors.transparent,
                      selectedColor: _wrongOtp
                          ? Constants.reddish
                          : Constants.secondary_color,
                      activeColor: _wrongOtp
                          ? Constants.reddish
                          : Constants.secondary_color,
                      shape: PinCodeFieldShape.box,
                      inactiveFillColor: Color(0XFFF4F4F4),
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      fieldWidth: 40.0,
                      fieldHeight: 50.0,
                      borderRadius: BorderRadius.circular(5.0)),
                  appContext: context,
                ),
              ),
            ),
            Visibility(
              visible: _wrongOtp,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 16.0),
                child: Text(
                  "The code you entered is incorrect or expired. Please verify and try again.",
                  style: TextStyle(color: Constants.reddish),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 16.0),
                child: Text(
                  "A code has been resent to your Phone number.",
                  style: TextStyle(color: Constants.primary_color),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            CountdownTimer(
              endTime: endTime,
              widgetBuilder: (context, time) {
                if (time == null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                          child: Text("RESEND OTP",
                              style:
                                  TextStyle(color: Constants.secondary_color)),
                          onPressed: () async {
                            _verifyPhoneNumber();
                          }),
                    ],
                  );
                }
                return Text('OTP will be sent in ${time.sec} secs');
              },
            ),
          ],
        ),
      ),
    );
  }
}
