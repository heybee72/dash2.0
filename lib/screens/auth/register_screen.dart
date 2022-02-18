import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user2/screens/auth/login_screen.dart';
import 'package:dash_user2/services/global_methods.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'get_phone_number.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';
  String? phoneNumber;
  RegisterScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';

  // final arg = ModalRoute.of(context)!.settings.arguments as Map;

  bool _isVisible = true;
  bool _loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();

  void _submitData() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var parsedDate = DateTime.parse(date);
    var formattedDate =
        '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
    if (_isValid) {
      setState(() {
        _loading = true;
      });
      _formKey.currentState!.save();
    }
    try {
      final User user = _auth.currentUser!;
      final _uid = user.uid;
      FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'id': _uid,
        'firstName': _firstName.trim(),
        'lastName': _lastName.trim(),
        'email': _email.toLowerCase().trim(),
        'phone': widget.phoneNumber.toString().trim(),
        'joinedDate': formattedDate,
        'createdAt': Timestamp.now(),
      });
      Navigator.canPop(context) ? Navigator.pop(context) : null;
    } catch (e) {
      _globalMethods.authDialog(context, e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  FocusNode _passwordFocusNode = new FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: Image.asset('assets/dash_logo_dark.png',
                          width: 200.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onSaved: (value) {
                              _firstName = value!;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(
                              _passwordFocusNode,
                            ),
                            keyboardType: TextInputType.text,
                            key: ValueKey('first_name'),
                            decoration: InputDecoration(
                              hintText: 'First name',
                              hintStyle: TextStyle(
                                  color: Color(0XFF777777), fontSize: 16.0),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Constants.secondary_color,
                                    width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value.contains(
                                      ' 1, 2, 3, 4, 5, 6, 7, 8, 9, 0')) {
                                return 'Invalid Name Input';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            onSaved: (value) {
                              _lastName = value!;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(
                              _passwordFocusNode,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            key: ValueKey('last_name'),
                            decoration: InputDecoration(
                              hintText: 'Last name',
                              hintStyle: TextStyle(
                                  color: Color(0XFF777777), fontSize: 16.0),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Constants.secondary_color,
                                    width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value.contains(
                                      '1, 2, 3, 4, 5, 6, 7, 8, 9, 0')) {
                                return 'Invalid Name Input';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (value) {
                        _email = value!;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(
                        _passwordFocusNode,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        hintStyle:
                            TextStyle(color: Color(0XFF777777), fontSize: 16.0),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Constants.secondary_color, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      onSaved: (value) {
                        _password = value!;
                      },
                      onEditingComplete: _submitData,
                      obscureText: _isVisible,
                      key: ValueKey('password'),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Color(0XFF777777),
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Constants.secondary_color, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: !_isVisible
                              ? Icon(
                                  Icons.visibility,
                                  color: Constants.secondary_color,
                                )
                              : Icon(Icons.visibility_off,
                                  color: Colors.black26),
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 64.0, right: 64.0, bottom: 10.0, top: 20.0),
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
                    Container(
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
                                "Sign Up",
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
