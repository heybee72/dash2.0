

import 'package:dash_user_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = '/otp';
  OtpScreen({
    Key? key,
    // required this.phone,
    // required this.verificationId,
    // required this.firstName,
    // required this.lastName,
    // required this.email,
    // required this.password
  }) : super(key: key);

  static const String idScreen = 'otp_screen';

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _loading = false;
  bool _wrongOtp = false;
  bool _resentCode = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController pinEditingController = TextEditingController();
  // AuthApi _authApi = AuthApi(token: '');
  // late AppState _appState;
  @override
  void didChangeDependencies() {
    // _appState = Provider.of<AppState>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Container(
                        margin: EdgeInsets.only(top: 12.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Enter Code",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, left: 16.0, right: 32.0, bottom: 54.0),
                child: Text(
                  "Please enter the 6-digit code ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0XFF777777)),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: PinCodeTextField(
                    controller: pinEditingController,
                    length: 6,
                    onChanged: (String value) {},
                    onCompleted: (String value) {
                      setState(() {
                        _wrongOtp = false;
                      });
                      // PhoneAuthCredential phoneAuthCredential =
                      // PhoneAuthProvider.credential(
                      //     verificationId: widget.verificationId,
                      //     smsCode: pinEditingController.text);
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
                visible: _resentCode,
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
              Center(
                child: GestureDetector(
                  onTap: null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      "",
                      style: TextStyle(color: Constants.primary_color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              )
            ],
          ),
          _loading ? Center(child: CircularProgressIndicator()) : Container()
        ],
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signInWithPhone(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      _loading = true;
    });
    // final User? firebaseUser = (await _firebaseAuth
    //         .createUserWithEmailAndPassword(
    //             email: widget.email, password: widget.password)
    //         .catchError((errMsg) {
    //   if (errMsg.code == "email-already-in-use") {
    //     Navigator.pop(context);

    //     displayToastMessage(
    //         "This Email has already been used, kindly Proceed to Login",
    //         context);
    //   } else if (errMsg.code == "weak-password") {
    //     Navigator.pop(context);

    //     displayToastMessage("Password looks Weak!", context);
    //   }
    // }))
    //     .user;

    // if (firebaseUser != null) {
    //   // Map userDataMap = {
    //   //   "firstName": widget.firstName.trim(),
    //   //   "lastName": widget.lastName.trim(),
    //   //   "email": widget.email.trim(),
    //   //   "phone": widget.phone.trim(),
    //   // };

    //   // userRef.child(firebaseUser.uid).set(userDataMap);

    //   try {
    //     // final authCredential =
    //     //     await _firebaseAuth.signInWithCredential(phoneAuthCredential);

    //     setState(() {
    //       _loading = false;
    //     });

    //     // if (authCredential.user != null) {
    //     // Navigator.pushNamedAndRemoveUntil(
    //     //     context, LoginScreen.idScreen, (route) => false);
    //     // }
    //   } on FirebaseAuthException catch (e) {
    //     print(e);

    //     setState(() {
    //       _wrongOtp = true;
    //       _loading = false;
    //     });
    //     displayToastMessage("${e.message}", context);
    //   }
    // }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
