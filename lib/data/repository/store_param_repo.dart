import 'dart:convert';

import 'package:dash_user_app/model/store_param.dart';
import 'package:dash_user_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreParamRepo {
  final SharedPreferences sharedPreferences;

  StoreParamRepo({required this.sharedPreferences});

  void addToParam(address, lat, lng) async {
    /*
      convert object to string because shared preferences only accepts string...
    */

    sharedPreferences.setString("address", address);
    sharedPreferences.setDouble("lat", lat);
    sharedPreferences.setDouble("lng", lng);
  }

  void updateToParam(category) async {
    /*
      convert object to string because shared preferences only accepts string...
    */

    sharedPreferences.setString("category", category);
  }

  String getParamAddress() {
    String address = "";

    if (sharedPreferences.containsKey("address")) {
      sharedPreferences.getString("address");
      address = sharedPreferences.getString("address")!;

      print(address.toString());
    }
    return address;
  }

  double getParamLatitude() {
    double lat = 0.00;

    if (sharedPreferences.containsKey("lat")) {
      sharedPreferences.getDouble("lat");
      lat = sharedPreferences.getDouble("lat")!;

      print(lat.toDouble());
    }
    return lat;
  }

  double getParamLongitude() {
    double lng = 0.00;

    if (sharedPreferences.containsKey("lng")) {
      sharedPreferences.getDouble("lng");
      lng = sharedPreferences.getDouble("lng")!;

      print(lng.toString());
    }
    return lng;
  }

  String getParamCategory() {
    String category = "";

    if (sharedPreferences.containsKey("category")) {
      sharedPreferences.getString("category");
      category = sharedPreferences.getString("category")!;

      print(category.toString());
    }
    return category;
  }
}
