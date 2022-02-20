import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_store/global/global.dart';
import 'package:dash_store/screens/home_screen.dart';
import 'package:dash_store/utils/constants.dart';
import 'package:dash_store/widgets/custom_text_field.dart';
import 'package:dash_store/widgets/error_dialog.dart';
import 'package:dash_store/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Position? position;
  List<Placemark>? placemark;
  String storeImageUrl = '';

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    position = newPosition;
    placemark = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    Placemark pMark = placemark![0];
    String completeAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode} ${pMark.country}';
    _locationController.text = completeAddress;
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: 'Please select a store image',
          );
        },
      );
    } else {
      if (_passwordController.text == _confirmPasswordController.text) {
        if (_passwordController.text.length < 6) {
          showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: 'Password must be at least 6 characters',
              );
            },
          );
        }
        if (_phoneController.text.length < 11) {
          showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: 'Phone number must be 11 digits',
              );
            },
          );
        }

        if (_confirmPasswordController.text.isNotEmpty &&
            _emailController.text.isNotEmpty &&
            _phoneController.text.isNotEmpty &&
            _storeNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            _locationController.text.isNotEmpty) {
          //  start uploading
          showDialog(
            context: context,
            builder: (c) {
              return LoadingDialog(
                message: 'Registering Account ',
              );
            },
          );
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child("stores")
              .child(fileName);
          fStorage.UploadTask uploadTask =
              reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            storeImageUrl = url;
            // save to database
            authenticateSellerAndSignUp();
          });
        } else {
          showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: 'Please fill all the fields',
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: 'password do not match!',
            );
          },
        );
      }
    }
  }

  void authenticateSellerAndSignUp() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: error.message.toString(),
          );
        },
      );
    });
    if (currentUser != null) {
      saveDataToFireStore(currentUser!).then((value) {
       
        Navigator.of(context).pop();

        Route newRoute = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFireStore(User currentUser) async {
    FirebaseFirestore.instance.collection("stores").doc(currentUser.uid).set({
      "storeUID": currentUser.uid,
      "storeEmail": currentUser.email,
      "storeName": _storeNameController.text.trim(),
      "storePhone": _phoneController.text.trim(),
      "storeImageUrl": storeImageUrl,
      "storeLocation": _locationController.text,
      "status": "approved",
      "earnings": 0.00,
      "lat": position!.latitude,
      "lng": position!.longitude,
    });

    // save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString('uid', currentUser.uid);
    await sharedPreferences!.setString('email', _emailController.text);
    await sharedPreferences!.setString('name', _storeNameController.text);
    await sharedPreferences!.setString('photoUrl', storeImageUrl);
    await sharedPreferences!.setString('phone', _phoneController.text);
  }

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Image.asset('assets/dash_logo_dark.png', width: 200.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Store Registration",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Constants.primary_color),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                _getImage();
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: MediaQuery.of(context).size.width * 0.15,
                backgroundImage: imageXFile == null
                    ? null
                    : FileImage(File(imageXFile!.path)),
                child: imageXFile == null
                    ? Icon(Icons.add_a_photo, size: 30, color: Colors.black)
                    : null,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _storeNameController,
                    hintText: 'Enter your Store Name',
                    data: Icons.verified_user,
                    inputType: TextInputType.text,
                  ),
                  CustomTextField(
                    controller: _phoneController,
                    hintText: 'Enter your Phone number',
                    data: Icons.phone,
                    inputType: TextInputType.phone,
                  ),
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
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confrim your Password',
                    data: Icons.password,
                    inputType: TextInputType.text,
                    isObscure: true,
                  ),
                  CustomTextField(
                    controller: _locationController,
                    hintText: 'Store/Outlet Address',
                    data: Icons.my_location,
                    enabled: false,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 45,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        getCurrentLocation();
                      },
                      label: Text("Get my Current Location"),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Constants.grey_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.location_on),
                    ),
                  ),
                  SizedBox(height: 10),
                  Terms(),
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
                        "Register",
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class Terms extends StatelessWidget {
  const Terms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                TextSpan(text: "By Signing up, you are agreeing to our "),
                TextSpan(
                    text: "Terms of Service & Privacy Policy",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline))
              ])),
    );
  }
}
