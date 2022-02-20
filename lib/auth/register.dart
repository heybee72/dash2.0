import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_rider/global/global.dart';
import 'package:dash_rider/screens/home_screen.dart';
import 'package:dash_rider/utils/constants.dart';
import 'package:dash_rider/widgets/custom_text_field.dart';
import 'package:dash_rider/widgets/error_dialog.dart';
import 'package:dash_rider/widgets/loading_dialog.dart';

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
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? imageSelfieXFile;
  XFile? imageFrontXFile;
  XFile? imageBackXFile;
  final ImagePicker _selfiePicker = ImagePicker();
  final ImagePicker _frontViewPicker = ImagePicker();
  final ImagePicker _backViewPicker = ImagePicker();

  Position? position;
  List<Placemark>? placemark;
  String selfieImageUrl = '';
  String frontImageUrl = '';
  String backImageUrl = '';
  var modeOfTransportation = "Car";

  Future<void> _getSelfieImage() async {
    imageSelfieXFile =
        await _selfiePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageSelfieXFile;
    });
  }

  Future<void> _getFrontImage() async {
    imageFrontXFile =
        await _frontViewPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFrontXFile;
    });
  }

  Future<void> _getBackImage() async {
    imageBackXFile =
        await _backViewPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageBackXFile;
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
    // Placemark pMark = placemark![0];
    // String completeAddress =
    //     '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode} ${pMark.country}';
    // _locationController.text = completeAddress;
  }

  Future<void> formValidation() async {
    if (imageSelfieXFile == null ||
        imageFrontXFile == null ||
        imageBackXFile == null) {
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: 'Please Ensure all Images are uploaded',
          );
        },
      );
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (passwordController.text.length < 6) {
          showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: 'Password must be at least 6 characters',
              );
            },
          );
        }
        if (phoneController.text.length < 11) {
          showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: 'Phone number must be 11 digits',
              );
            },
          );
        }

        if (confirmPasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            fullnameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            addressController.text.isNotEmpty) {
          //  start uploading
          showDialog(
            context: context,
            builder: (c) {
              return LoadingDialog(
                message: 'Registering Account ',
              );
            },
          );
          authenticateRiderAndSignUp();
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

  void authenticateRiderAndSignUp() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) async {
      String fileName1 = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName2 = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName3 = DateTime.now().millisecondsSinceEpoch.toString();
      fStorage.Reference reference1 = fStorage.FirebaseStorage.instance
          .ref()
          .child("riders")
          .child(fileName1);
      fStorage.Reference reference2 = fStorage.FirebaseStorage.instance
          .ref()
          .child("riders")
          .child(fileName2);

      fStorage.Reference reference3 = fStorage.FirebaseStorage.instance
          .ref()
          .child("riders")
          .child(fileName3);

      fStorage.UploadTask uploadTask1 =
          reference1.putFile(File(imageSelfieXFile!.path));
      fStorage.UploadTask uploadTask2 =
          reference2.putFile(File(imageFrontXFile!.path));
      fStorage.UploadTask uploadTask3 =
          reference3.putFile(File(imageBackXFile!.path));

      fStorage.TaskSnapshot taskSnapshot1 =
          await uploadTask1.whenComplete(() {});
      fStorage.TaskSnapshot taskSnapshot2 =
          await uploadTask2.whenComplete(() {});
      fStorage.TaskSnapshot taskSnapshot3 =
          await uploadTask3.whenComplete(() {});

      await taskSnapshot1.ref.getDownloadURL().then((url) {
        selfieImageUrl = url;
        // save to database
      });
      await taskSnapshot2.ref.getDownloadURL().then((url2) {
        frontImageUrl = url2;
        // save to database
      });
      await taskSnapshot3.ref.getDownloadURL().then((url3) {
        backImageUrl = url3;
        // save to database
      });

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
    FirebaseFirestore.instance.collection("riders").doc(currentUser.uid).set({
      "riderUID": currentUser.uid,
      "riderEmail": currentUser.email,
      "riderName": fullnameController.text.trim(),
      "riderPhone": phoneController.text.trim(),
      "selfieImageUrl": selfieImageUrl,
      "frontImageUrl": frontImageUrl,
      "backImageUrl": backImageUrl,
      "address": addressController.text,
      "status": "approved",
      "earnings": 0.00,
      // "lat": position!.latitude,
      // "lng": position!.longitude,
    });

    // save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString('uid', currentUser.uid);
    await sharedPreferences!.setString('email', emailController.text);
    await sharedPreferences!.setString('name', fullnameController.text);
    await sharedPreferences!.setString('photoUrl', selfieImageUrl);
    await sharedPreferences!.setString('phone', phoneController.text);
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
                "Rider Registration",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Constants.primary_color),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                _getSelfieImage();
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: MediaQuery.of(context).size.width * 0.15,
                backgroundImage: imageSelfieXFile == null
                    ? null
                    : FileImage(File(imageSelfieXFile!.path)),
                child: imageSelfieXFile == null
                    ? Icon(Icons.add_a_photo, size: 30, color: Colors.black)
                    : null,
              ),
            ),
            Text("Selfie Photo*",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: fullnameController,
                    hintText: 'Full Name',
                    data: Icons.verified_user,
                    inputType: TextInputType.text,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    hintText: 'Phone number',
                    data: Icons.phone,
                    inputType: TextInputType.phone,
                  ),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    data: Icons.email,
                    inputType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    data: Icons.password,
                    inputType: TextInputType.text,
                    isObscure: true,
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confrim your Password',
                    data: Icons.password,
                    inputType: TextInputType.text,
                    isObscure: true,
                  ),
                  CustomTextField(
                    controller: addressController,
                    hintText: 'Permanent address',
                    data: Icons.my_location,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 8,
                    ),
                    child: Text("Select a Mode of transportation"),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 4,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 4,
                        bottom: 4,
                      ),
                      decoration: ShapeDecoration(
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.0,
                            color: Color(0xffF4F4F4),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: modeOfTransportation,
                          elevation: 16,
                          iconSize: 0.0,
                          onChanged: (String? newValue) {
                            setState(() {
                              modeOfTransportation = newValue!;
                            });
                          },
                          items: <String>["Car", "Bike", "Walk"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 4,
                      bottom: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _getFrontImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  radius:
                                      MediaQuery.of(context).size.width * 0.1,
                                  backgroundImage: imageFrontXFile == null
                                      ? null
                                      : FileImage(File(imageFrontXFile!.path)),
                                  child: imageFrontXFile == null
                                      ? Icon(Icons.add_a_photo,
                                          size: 30, color: Colors.black)
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 14.0),
                                child: Text("Valid ID Card - front view*",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _getBackImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  radius:
                                      MediaQuery.of(context).size.width * 0.1,
                                  backgroundImage: imageBackXFile == null
                                      ? null
                                      : FileImage(File(imageBackXFile!.path)),
                                  child: imageBackXFile == null
                                      ? Icon(Icons.add_a_photo,
                                          size: 30, color: Colors.black)
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 14.0),
                                child: Text("Valid ID Card - back view*",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
