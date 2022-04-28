import 'dart:io';

import 'package:address_search_field/address_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_store/dataHandler/appData.dart';
import 'package:dash_store/global/global.dart';
import 'package:dash_store/models/address.dart';
import 'package:dash_store/models/place_predictions.dart';
import 'package:dash_store/new_model/data_class.dart';
import 'package:dash_store/new_model/signup_model.dart';
import 'package:dash_store/screens/home_screen.dart';
import 'package:dash_store/utils/configMaps.dart';
import 'package:dash_store/utils/constants.dart';
import 'package:dash_store/utils/requestAssistants.dart';
import 'package:dash_store/widgets/custom_text_field.dart';
import 'package:dash_store/widgets/divider.dart';
import 'package:dash_store/widgets/error_dialog.dart';
import 'package:dash_store/widgets/loading_dialog.dart';
import 'package:dash_store/widgets/progressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

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

  final geoMethods = GeoMethods(
    googleApiKey: '${mapKey}',
    language: 'en',
    country: 'Nigeria',
  );

  LatLng _initialPositon = LatLng(0.00, 0.0000);
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Food"), value: "Food"),
      DropdownMenuItem(child: Text("Groceries"), value: "Groceries"),
      DropdownMenuItem(child: Text("Pharmacy"), value: "Pharmacy"),
    ];
    return menuItems;
  }

  String selectedValue = "Food";

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String storeImageUrl = '';
  final geo = Geoflutterfire();
  String lat = '';
  String lng = '';

  List<PlacePredictions> placePrecidtionList = [];
  final origCtrl = TextEditingController();

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
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
            selectedValue.isNotEmpty &&
            origCtrl.text.isNotEmpty) {
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
    GeoFirePoint myLocation =
        geo.point(latitude: double.parse(lat), longitude: double.parse(lng));

    try {
      // SignUpBody signupBody = SignUpBody(
      //   storeEmail: ,
      //   category: ,
      //   lat: double.parse(lat),
      //   lng: double.parse(lng),
      //   password: ,
      //   storeImage: ,
      //   storeLocation: ,
      //   storeName:,
      //   storePhone: ,
      //   storeTags: 'amala',
      //   uid:
      // );
      // var provider = Provider.of<DataClass>(context, listen: false);
      // await provider.postData(signupBody);
      // if (provider.isBack) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://dash.toptechng.com/api/store/register'));
      request.fields.addAll({
        'storeName': _storeNameController.text.trim(),
        'storeEmail': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
        'storePhone': _phoneController.text.trim(),
        'lng': lng,
        'lat': lat,
        'storeLocation': origCtrl.text,
        'storeImage': storeImageUrl,
        'storeTags': 'amala',
        'category': selectedValue,
        'uid': currentUser.uid,
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());

        FirebaseFirestore.instance
            .collection("stores")
            .doc(currentUser.uid)
            .set({
          "storeUID": currentUser.uid,
          "storeEmail": currentUser.email,
          "storeName": _storeNameController.text.trim(),
          "storePhone": _phoneController.text.trim(),
          "storeImageUrl": storeImageUrl,
          "storeLocation": origCtrl.text,
          "status": "approved",
          "earnings": 0.00,
          "lat": double.parse(lat),
          "lng": double.parse(lng),
          "category": selectedValue,
          'position': myLocation.data
        });

        // save data locally
        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences!.setString('uid', currentUser.uid);
        await sharedPreferences!.setString('email', _emailController.text);
        await sharedPreferences!.setString('name', _storeNameController.text);
        await sharedPreferences!.setString('photoUrl', storeImageUrl);
        await sharedPreferences!.setString('phone', _phoneController.text);
      } else {
        print(response.reasonPhrase);
      }

      // }
    } catch (e) {
      print("an error occurred");
      print(e);
    }
  }

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Image.asset('assets/dash_logo_dark.png', width: 150.0),
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
                  // CustomTextField(
                  //   controller: _locationController,
                  //   hintText: 'Store/Outlet Address',
                  //   data: Icons.my_location,
                  // ),
                  // Opacity(
                  //   opacity: 0,

                  RouteSearchBox(
                    geoMethods: geoMethods,
                    originCtrl: origCtrl,
                    destinationCtrl: origCtrl,
                    builder: (context,
                        originBuilder,
                        destinationBuilder,
                        waypointBuilder,
                        waypointsMgr,
                        relocate,
                        getDirections) {
                      if (origCtrl.text.isEmpty)
                        relocate(AddressId.origin, _initialPositon.toCoords());
                      return Container(
                        margin: EdgeInsets.all(4),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: origCtrl,
                          // enabled: false,
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => originBuilder.buildDefault(
                              builder: AddressDialogBuilder(),
                              onDone: (address) async {
                                String data = address.coords!.toString();
                                final splitted = data.split(',');
                                setState(() {
                                  _initialPositon = address.coords!;
                                  lat = splitted[0];
                                  lng = splitted[1];
                                });
                              },
                            ),
                          ),
                          cursorColor: Constants.primary_color,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.my_location,
                                size: 16, color: Constants.primary_color),
                            hintText: 'Store/Outlet Address',
                            hintStyle: TextStyle(
                                color: Color(0XFF777777), fontSize: 14.0),
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
                        ),
                      );
                    },
                  ),

                  Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.category_outlined,
                            size: 16, color: Constants.primary_color),
                        hintText: "Select A Store Category",
                        hintStyle:
                            TextStyle(color: Color(0XFF777777), fontSize: 14.0),
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
                      value: selectedValue,
                      items: dropdownItems,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                    ),
                  ),
// ====================//
                  // Container(
                  //   margin: EdgeInsets.all(4),
                  //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   child: TextFormField(
                  //     controller: _locationController,
                  //     cursorColor: Constants.primary_color,
                  //     textInputAction: TextInputAction.next,
                  //     keyboardType: TextInputType.text,
                  //     decoration: InputDecoration(
                  //       prefixIcon: Icon(Icons.my_location,
                  //           size: 16, color: Constants.primary_color),
                  //       hintText: 'Store/Outlet Address',
                  //       hintStyle:
                  //           TextStyle(color: Color(0XFF777777), fontSize: 14.0),
                  //       filled: true,
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(
                  //             color: Constants.secondary_color, width: 2.0),
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // ///////////////////////////////////////
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // (placePrecidtionList.length > 0)
                  //     ? Padding(
                  //         padding: EdgeInsets.symmetric(
                  //           vertical: 8,
                  //           horizontal: 16.0,
                  //         ),
                  //         child: ListView.separated(
                  //           padding: EdgeInsets.all(0),
                  //           itemBuilder: (context, index) {
                  //             return PredictionTile(
                  //               placePrecidtions: placePrecidtionList[index],
                  //             );
                  //           },
                  //           separatorBuilder: (BuildContext context, index) =>
                  //               Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: DividerWidget(),
                  //           ),
                  //           itemCount: placePrecidtionList.length,
                  //           shrinkWrap: true,
                  //           physics: ClampingScrollPhysics(),
                  //         ),
                  //       )
                  //     : Container(),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.9,
                  //   height: 45,
                  //   child: ElevatedButton.icon(
                  //     onPressed: () {
                  //       // getCurrentLocation();
                  //     },
                  //     label: Text("Get my Current Location"),
                  //     style: ElevatedButton.styleFrom(
                  //       elevation: 0,
                  //       primary: Constants.grey_color,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //     ),
                  //     icon: Icon(Icons.location_on),
                  //   ),
                  // ),
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
