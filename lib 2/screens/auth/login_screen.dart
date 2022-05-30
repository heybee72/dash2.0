import 'package:dash_user_app/screens/auth/forgot_password_screen.dart';
import 'package:dash_user_app/screens/auth/register_screen.dart';
import 'package:dash_user_app/services/global_methods.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  bool _isVisible = true;
  bool _loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();

  void _submitData() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      setState(() {
        _loading = true;
      });
      _formKey.currentState!.save();
    }
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: _email.toLowerCase().trim(), password: _password)
          .then((value) =>
              Navigator.canPop(context) ? Navigator.pop(context) : null);
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
                    SizedBox(height: 100),
                    Center(
                        child: Image.asset('assets/dash_logo_dark.png',
                            width: 200.0)),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ForgotPasswordScreen.routeName);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 16.0, top: 13),
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
                    SizedBox(height: 30),
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
                                "Login",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'EuclidCircularB',
                                ),
                              ),
                        onPressed: () {
                          _submitData();
                          // Navigator.of(context)
                          //     .pushNamed(LoginScreen.routeName);
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
                          Navigator.pushNamedAndRemoveUntil(context,
                              RegisterScreen.routeName, (route) => false);
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
                                ])),
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
