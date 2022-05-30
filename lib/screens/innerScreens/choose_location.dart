import 'dart:async';

import 'package:dash_user_app/controllers/items_controller.dart';
import 'package:dash_user_app/controllers/store_controller.dart';
import 'package:dash_user_app/controllers/store_param_controller.dart';
import 'package:dash_user_app/utils/app_constants.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/dimensions.dart';
import 'package:dash_user_app/widgets/choose_location_small_text.dart';
import 'package:dash_user_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/utils/google_search/place_type.dart';
import 'package:search_map_location/widget/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_nav_screen.dart';
import 'choose_category.dart';

class ChooseLocation extends StatefulWidget {
  ChooseLocation({Key? key}) : super(key: key);

  static const String routeName = 'choose_location';

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  Position? currentPosition;
  var geolocator = Geolocator();
  double bottomPaddingOfMap = 0;
  double containerHeight = 0;

  // List<PlacePredictions> placePrecidtionList = [];

  TextEditingController pickUpTextEditingController = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Enter Delivery Location",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
             
              SizedBox(
                height: Dimensions.height45,
              ),
              GetBuilder<StoreParamController>(
                builder: (params) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SearchLocation(
                      apiKey: AppConstant.MAP_API_KEY,
                      country: 'NG',
                      placeholder: 'Enter a new address',
                      onSelected: (Place place) async {
                        final geolocation = await place.geolocation;
                        params.addParam(
                            place.description,
                            geolocation!.coordinates.latitude,
                            geolocation.coordinates.longitude,
                            '');
                        Get.toNamed(ChooseCategory.routeName);
                      },
                    ),
                  );
                },
              ),
              Container(
                height: Dimensions.height45 + 30,
                margin: EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: () {
                    setState(() {
                      Get.find<ItemController>().getItemList('');
                    });
                    Navigator.of(context).pushNamed(BottomNavScreen.routeName);
                    // Get.offAllNamed(ChooseLocation.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Image.asset("assets/location_arrow.png", width: 25),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Location",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: Dimensions.height10 - 5,
                            ),
                            GetBuilder<StoreParamController>(
                              builder: (params) {
                                return ChooseLocationSmallText(
                                  color: Colors.black54,
                                  text: params.getParamAddress(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // void findPlace(String placeName) async {
  //   if (placeName.length > 1) {
  //     String autoCompleteUrl =
  //         "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&components=country:ng&radius=500";

  //     var res = await RequestAssistant.getRequest(autoCompleteUrl);

  //     if (res == "Failed") {
  //       return;
  //     } else {
  //       if (res['status'] == "OK") {
  //         var predictions = res['predictions'];

  //         print("predictions");
  //         print(predictions);

  //         var placesList = (predictions as List)
  //             .map((e) => PlacePredictions.fromJson(e))
  //             .toList();
  //         setState(() {
  //           placePrecidtionList = placesList;
  //         });
  //       }
  //     }
  //   }
  // }
}
