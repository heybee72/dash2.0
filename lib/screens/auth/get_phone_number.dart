import 'package:country_code_picker/country_code_picker.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'verify_phone_number.dart';

class GetPhoneNumberScreen extends StatefulWidget {
  static const routeName = '/get-phone-number';
  GetPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<GetPhoneNumberScreen> createState() => _GetPhoneNumberScreenState();
}

class _GetPhoneNumberScreenState extends State<GetPhoneNumberScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String _phone = '';
  String phoneIsoCode = "+234";
  @override
  void _submitData() {
    final _isValid = _formKey.currentState!.validate();
    if (_isValid) {
      setState(() {
        _loading = true;
      });
      _formKey.currentState!.save();
    }
    var phonenumber = _phone.trim();

    phonenumber = phonenumber.substring(0, 1);

    if (phonenumber == "0") {
      _phone = _phone.substring(1, _phone.length);
    } else {
      _phone;
    }
    _phone = phoneIsoCode + _phone;

    setState(() {
      _loading = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return VerifyPhoneNumber(phoneNumber: _phone);
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Image.asset('assets/dash_logo_dark.png', width: 250.0),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 50.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(left: 16.0, right: 8.0),
                            decoration: BoxDecoration(
                                color: Color(0XFFF4F4F4),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: CountryCodePicker(
                              padding: EdgeInsets.only(top: 14, bottom: 14),

                              onChanged: (CountryCode countryCode) {
                                phoneIsoCode = countryCode.dialCode!;
                              },
                              initialSelection: 'NG',
                              favorite: ['NG', 'ZA', 'GB', 'US'],
                              showCountryOnly: false,
                              showFlag: false,
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                              textStyle: TextStyle(
                                  color: Color(0XFF777777),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: TextFormField(
                              onSaved: (value) {
                                _phone = value!;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              key: ValueKey('phone'),
                              decoration: InputDecoration(
                                hintText: 'Phone number',
                                hintStyle: TextStyle(
                                    color: Color(0XFF777777), fontSize: 16.0),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Constants.secondary_color,
                                      width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.length == 0) {
                                  return 'Please enter mobile number';
                                } else if (value.length < 10) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 64.0, right: 64.0, bottom: 10.0, top: 40.0),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0XFF777777),
                                fontFamily: 'EuclidCircularB'),
                            children: [
                              TextSpan(
                                  text:
                                      "By Signing up, you are agreeing to our "),
                              TextSpan(
                                  text: "Terms of Service & Privacy Policy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline))
                            ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
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
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'EuclidCircularB',
                                ),
                              ),
                        onPressed: _submitData,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
