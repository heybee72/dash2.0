import 'package:dash_user2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneNumber extends StatefulWidget {
  static const routeName = '/verify-phone-number';
  VerifyPhoneNumber({Key? key}) : super(key: key);

  @override
  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool _loading = false;
    bool _wrongOtp = false;
    bool _resentCode = false;

    TextEditingController pinEditingController = TextEditingController();
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
                "Please enter the 4-digit code sent to +234 81222333",
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
                  onChanged: (String value) {},
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
          ],
        ),
      ),
    );
  }
}
