import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user_app/dataHandler/app_data.dart';
import 'package:dash_user_app/global/global.dart';
import 'package:dash_user_app/models&providers/store.dart';
import 'package:dash_user_app/screens/innerScreens/choose_category.dart';
import 'package:dash_user_app/screens/innerScreens/select_location.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/set_pref.dart';
import 'package:dash_user_app/widgets/empty_cart.dart';
import 'package:dash_user_app/widgets/no_delivery.dart';
import 'package:dash_user_app/widgets/store_lists.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stores extends StatefulWidget {
  Stores({Key? key}) : super(key: key);

  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  Position? position;
  List<Placemark>? placemark;
  String _locationController = '';
  final geo = Geoflutterfire();

  late Permission permission;
  PermissionStatus permissionStatus = PermissionStatus.denied;
  void _listenForPermission() async {
    final status = await Permission.location.status;
    setState(() {
      permissionStatus = status;
    });
    switch (status) {
      case PermissionStatus.denied:
        requestForPermissions();
        break;

      case PermissionStatus.restricted:
        Navigator.pop(context);

        break;
      case PermissionStatus.limited:
        Navigator.pop(context);

        break;
      case PermissionStatus.permanentlyDenied:
        Navigator.pop(context);

        break;
      case PermissionStatus.granted:
        break;
    }
  }

  Future<void> requestForPermissions() async {
    final status = await Permission.location.request();
    setState(() {
      permissionStatus = status;
    });
  }

  void getData() async {
    await _getCurrentLocation();
     Provider.of<StoreProvider>(context, listen: false).fetchStores();
  }

  initState() {
    super.initState();
    getData();
  }

  Future _getCurrentLocation() async {
    _listenForPermission();
    bool serviceEnabled;
    bool permisionGranted = false;
    LocationPermission permission;

    var perm = await Geolocator.checkPermission();

    permisionGranted = perm == LocationPermission.whileInUse ||
        perm == LocationPermission.always;

    if (!permisionGranted) {
      await Geolocator.requestPermission();
    }
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Geolocator.requestPermission();
      
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
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

    setState(() {
      _locationController = completeAddress;

      User? user = FirebaseAuth.instance.currentUser;

      GeoFirePoint myLocation = geo.point(
          latitude: position!.latitude, longitude: position!.longitude);

      FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: user!.uid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          element.reference.update({
            "location": _locationController,
            "lat": position!.latitude,
            "lng": position!.longitude,
            'position': myLocation.data
          });
        });
      });
    });

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString('location', _locationController);
    await sharedPreferences!.setDouble('lat', position!.latitude);
    await sharedPreferences!.setDouble('lng', position!.longitude);

    return newPosition;
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);
    storeProvider.fetchStores();
    List<Store> storesList = storeProvider.stores;
    print("this is the item after fetch ${storesList.length}");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.black, size: 16),
                          SizedBox(width: 5.0),
                          _locationController != ''
                              ? _locationController.length > 20
                                  ? Text(
                                      "${_locationController.substring(0, 18)}...",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black))
                                  : Text("${_locationController}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black))
                              : Text('Select Location',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.black),
                        ],
                      ),
                      onPressed: () {
                        // Navigator.pushNamedAndRemoveUntil(context,
                        //     ChooseLocation.routeName, (route) => false);
                        _getCurrentLocation();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ChooseCategory.routeName);
                      },
                      child: Row(
                        children: [
                          Text('Category',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: storesList.length == 0
                  ? NoDelivery()
                  : ListView.builder(
                      itemBuilder: (context, i) {
                        return ChangeNotifierProvider.value(
                          value: storesList[i],
                          child: StoreLists(),
                        );
                      },
                      itemCount: storesList.length,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
