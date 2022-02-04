

import 'package:dash_user2/dataHandler/appData.dart';
import 'package:dash_user2/models/address.dart';
import 'package:dash_user2/utils/configMaps.dart';

// import 'package:http/http.dart' as http;

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'requestAssistants.dart';

class AssistantMethods {
  static Future<String> searchCordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if (response != "Failed") {
// TODO:: Update the user profile with the cordinates here...

      // placeAddress = response['results'][0]['formatted_address'];
      st1 = response['results'][0]['address_components'][0]['long_name'];
      st2 = response['results'][0]['address_components'][1]['long_name'];
      st3 = response['results'][0]['address_components'][2]['long_name'];

      st4 = response['results'][5]['formatted_address'];

      placeAddress = st1 + ", " + st2 + ", " + st3;

      Address userPickupAddress = new Address();
      userPickupAddress.longitude = position.longitude;
      userPickupAddress.latitude = position.latitude;
      userPickupAddress.placeName = placeAddress;
      userPickupAddress.locality = st4;

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickupAddress);
    }

    return placeAddress;
  }

  // static Future<DirectionDetails?> obtainPlaceDirectionsDetails(
  //     LatLng initialPosition, LatLng finalPosition) async {
  //   String directionUrl =
  //       "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

  //   var res = await RequestAssistant.getRequest(directionUrl);
  //   if (res == "failed") {
  //     return null;
  //   }

  //   DirectionDetails directionDetails = DirectionDetails(
  //     distanceText: '',
  //     distanceValue: 0,
  //     durationText: '',
  //     durationValue: 0,
  //     encodedPoints: '',
  //   );
  //   directionDetails.encodedPoints =
  //       res['routes'][0]['overview_polyline']['points'];
  //   directionDetails.distanceText =
  //       res['routes'][0]['legs'][0]['distance']['text'];
  //   directionDetails.distanceValue =
  //       res['routes'][0]['legs'][0]['distance']['value'];

  //   directionDetails.durationText =
  //       res['routes'][0]['legs'][0]['duration']['text'];
  //   directionDetails.durationValue =
  //       res['routes'][0]['legs'][0]['duration']['value'];

  //   return directionDetails;
  // }

  // static int calculateFares(DirectionDetails directionDetails) {
  //   // in USD
  //   double timeTraveledFares = (directionDetails.durationValue / 60) * 0.20;
  //   double distanceTraveledFares =
  //       (directionDetails.distanceValue / 1000) * 0.20;

  //   double totalFareAmount = timeTraveledFares + distanceTraveledFares;

  //   // 1$ = 410Naira

  //   double totalLocalAmount = totalFareAmount * 150;

  //   return totalLocalAmount.truncate();
  // }

  // static void getCurrentOnlineInfo() async {
  //   firebaseUser = await FirebaseAuth.instance.currentUser;
  //   String userId = firebaseUser!.uid;
  //   DatabaseReference reference =
  //       FirebaseDatabase.instance.reference().child("users").child(userId);

  //   reference.once().then((DataSnapshot dataSnapshot) {
  //     if (dataSnapshot.value != null) {
  //       userCurrentInfo = Users.fromSnapshot(dataSnapshot);
  //     }
  //   });
  // }

  // static double createRandomNumber(int num) {
  //   var ran = Random();
  //   int radNumber = ran.nextInt(num);

  //   return radNumber.toDouble();
  // }

  // static sendNotificationToDriver(
  //     String token, context, String ride_request_id) async {
  //   var destination =
  //       Provider.of<AppData>(context, listen: false).dropOffLocation;
  //   Map<String, String> headerMap = {
  //     'Content-Type': 'application/json',
  //     'Authorization': serverToken,
  //   };

  //   Map notificationmap = {
  //     "title": "New Ride Alert",
  //     "body": "Destination: ${destination!.placeName}"
  //   };

  //   Map dataMap = {
  //     "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //     "id": "1",
  //     "status": "done",
  //     "ride_request_id": ride_request_id
  //   };

  //   Map sendNotificationMap = {
  //     "notification": notificationmap,
  //     "data": dataMap,
  //     "priority": "high",
  //     "to": token
  //   };
  //   var res = await http.post(
  //     Uri.parse("https://fcm.googleapis.com/fcm/send"),
  //     headers: headerMap,
  //     body: jsonEncode(sendNotificationMap),
  //   );
  // }

  // static double getBearingBetweenTwoPoints1(latLng1, latLng2) {
  //   double lat1 = latLng1.latitude * pi / 180.0;
  //   double long1 = latLng1.longitude * pi / 180.0;
  //   double lat2 = latLng2.latitude * pi / 180.0;
  //   double long2 = latLng2.longitude * pi / 180.0;

  //   double dLon = (long2 - long1);

  //   double y = sin(dLon) * cos(lat2);
  //   double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

  //   double radiansBearing = atan2(y, x);
  //   print("bearing");
  //   print(radiansBearing);
  //   return radiansBearing.toDouble();
  // }

  // static getCurrency() {
  //   var format =
  //       NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  //   print("symbol: ${format.currencySymbol}");
  //   return format.currencySymbol.toString();
  // }
}
