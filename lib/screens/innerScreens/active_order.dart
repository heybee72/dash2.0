import 'dart:async';
import 'dart:developer';
import 'package:dash_user2/assistants/assistantMethods.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:firebase_database/firebase_database.dart' show Event;
import 'package:provider/provider.dart';

class ActiveOrder extends StatefulWidget {
  @override
  State<ActiveOrder> createState() => ActiveOrderState();
}

class ActiveOrderState extends State<ActiveOrder> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;


  Position? currentPosition;
  var geolocator = Geolocator();

  double bottomPaddingOfMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
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
    print("this is your address ::"+address);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
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
                  // bottomPaddingOfMap = 265;
                });
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 1,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 16,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: Image.asset(
                              "assets/profile_dark.png",
                              width: 45,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            "Ali Y.",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Constants.primary_color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Container(
                        child: new CircleAvatar(
                          child: Icon(
                            Icons.phone_outlined,
                            color: Colors.black,
                            size: 26,
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white,
                        ),
                        width: 45.0,
                        height: 45.0,
                        padding: const EdgeInsets.all(2.0),
                        decoration: new BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyData() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80.0,
          ),
          const SizedBox(
            height: 24.0,
          ),
          Text(
            'You do not have an any active order.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24.0,
          ),
          Text(
            'Browse and select available items in stores to create an order',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
