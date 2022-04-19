import 'dart:async';

import 'package:dash_user_app/assistants/assistant_methods.dart';
import 'package:dash_user_app/new_models/request_assistants.dart';
import 'package:dash_user_app/dataHandler/app_data.dart';
import 'package:dash_user_app/global/global.dart';
import 'package:dash_user_app/models/address.dart';
import 'package:dash_user_app/models/place_predictions.dart';
import 'package:dash_user_app/new_provider/store_provider.dart';
import 'package:dash_user_app/utils/config_maps.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/widgets/divider.dart';
import 'package:dash_user_app/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
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

  List<PlacePredictions> placePrecidtionList = [];

  TextEditingController pickUpTextEditingController = TextEditingController();

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(
      target: latLngPosition,
      zoom: 14,
    );

    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistantMethods.searchCordinateAddress(position, context);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0,
            child: GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                locatePosition();

                setState(() {
                  bottomPaddingOfMap = MediaQuery.of(context).size.height * 0.1;
                });
              },
            ),
          ),
          ListView(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 7.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios, size: 16),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 33.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Color(0XFFF4F4F4),
                    borderRadius: BorderRadius.circular(5.0)),
                child: TextField(
                  onChanged: (val) {
                    findPlace(val);
                  },
                  controller: pickUpTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ImageIcon(
                          AssetImage(
                            'assets/location_pin.png',
                          ),
                          color: Color(0XFF777777),
                          size: 16.0,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.only(left: 0.0, top: 14.0, bottom: 14.0),
                      hintStyle: TextStyle(
                          color: Color(
                            0XFF777777,
                          ),
                          fontSize: 14.0),
                      hintText: "Enter city",
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (placePrecidtionList.length > 0)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16.0,
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return PredictionTile(
                            placePrecidtions: placePrecidtionList[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, index) =>
                            Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DividerWidget(),
                        ),
                        itemCount: placePrecidtionList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                      ),
                    )
                  : Container(),
              ListTile(
                contentPadding: const EdgeInsets.only(top: 14.0),
                onTap: () async {
                  // Navigator.of(context).push(PageTransition(
                  //       child: BottomNavScreen(),
                  //       type: PageTransitionType.rightToLeftWithFade));
                },
                title: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ImageIcon(
                            AssetImage('assets/location_arrow.png'),
                            size: 16.0,
                            color: Constants.primary_color,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Current location",
                            style: TextStyle(
                                color: Constants.primary_color, fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          Provider.of<AppData>(context).deliveryLocation != null
                              ? "${Provider.of<AppData>(context).deliveryLocation!.placeName!}"
                              : "No Location Found",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Constants.grey_color, fontSize: 14.0),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&components=country:ng&radius=500";

      var res = await RequestAssistant.getRequest(autoCompleteUrl);

      if (res == "Failed") {
        return;
      } else {
        if (res['status'] == "OK") {
          var predictions = res['predictions'];

          var placesList = (predictions as List)
              .map((e) => PlacePredictions.fromJson(e))
              .toList();
          setState(() {
            placePrecidtionList = placesList;
          });
        }
      }
    }
  }
}

class PredictionTile extends StatefulWidget {
  PredictionTile({Key? key, required this.placePrecidtions}) : super(key: key);

  final PlacePredictions placePrecidtions;

  @override
  _PredictionTileState createState() => _PredictionTileState();
}

class _PredictionTileState extends State<PredictionTile> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        getPlaceAddressDetails("${widget.placePrecidtions.place_id}", context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${widget.placePrecidtions.main_text}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Constants.primary_color,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${widget.placePrecidtions.secondary_text}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

void getPlaceAddressDetails(String placeId, context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(message: "Please Wait..."));
  String placDetailsUrl =
      "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

  var res = await RequestAssistant.getRequest(placDetailsUrl);

  if (res == "failed") {
    Navigator.pop(context);
    return;
  } else {
    if (res['status'] == 'OK') {
      Navigator.pop(context);

      Address address = Address();

      address.placeName = res['result']['name'];
      address.placeId = placeId;
      address.latitude = res['result']['geometry']['location']['lat'];
      address.longitude = res['result']['geometry']['location']['lng'];

      // store in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('selected_location', address.placeName.toString());
      prefs.setDouble('selected_lat', address.latitude!.toDouble());
      prefs.setDouble('selected_lng', address.longitude!.toDouble());

      Provider.of<AppData>(context, listen: false)
          .updateDeliveryLocationAddress(address);

      String? prefCat = prefs.getString('prefCat');

    //  await Provider.of<StoreModels>(context).fetchAndSetStore(
    //       cat: prefCat, lat: address.latitude, lng: address.longitude);

      prefCat == null
          ? Navigator.pushNamed(context, ChooseCategory.routeName)
          : Navigator.of(context).push(PageTransition(
              child: BottomNavScreen(),
              type: PageTransitionType.rightToLeftWithFade));
    }
  }
}
