
import 'package:dash_user_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password-screen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';

  bool _loading = false;

  void _submitData() {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      _formKey.currentState!.save();
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(73.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      "Reset Password",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "Enter your email to reset your password",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 90),
                    TextFormField(
                      onSaved: (value) {
                        email = value!;
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
                                "Reset Password",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'EuclidCircularB',
                                ),
                              ),
                        onPressed: _submitData,
                          // Navigator.of(context)
                          //     .pushNamed(LoginScreen.routeName);
                        
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
