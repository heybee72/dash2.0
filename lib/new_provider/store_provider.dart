import 'dart:convert';
import 'package:dash_user_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StoreModel {
  String uid;
  String storeName;
  String storeEmail;
  String storePhone;
  String lat;
  String lng;
  String storeImage;
  String storeLocation;
  String status;
  String storeTags;
  String category;
  String distance;

  StoreModel(
      {required this.uid,
      required this.storeName,
      required this.storeEmail,
      required this.storePhone,
      required this.lat,
      required this.lng,
      required this.storeImage,
      required this.storeLocation,
      required this.status,
      required this.storeTags,
      required this.category,
      required this.distance});
}

class StoreModels with ChangeNotifier {
  List<StoreModel> _storeModels = [];
  bool fetchStatus = false;
  List<StoreModel> get storeModels => _storeModels;

  //
  Future<void> fetchAndSetStore(
      {required lat, required lng, required cat}) async {
    final url = Constants.base_url + '/user/fetchStores/$lat/$lng/$cat';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
      );

      _storeModels.clear();

      if (response.statusCode == 200) {
        _storeModels.clear();

        print("this is the status code for 200");
        print(response.statusCode);
        final extractedData = json.decode(response.body);
        List data = (extractedData['store'] as List);
        for (var store in data) {
          _storeModels.add(StoreModel(
            uid: store['uid'],
            storeName: store['storeName'],
            storeEmail: store['storeEmail'],
            storePhone: store['storePhone'],
            lat: store['lat'],
            lng: store['lng'],
            storeImage: store['storeImage'],
            storeLocation: store['storeLocation'],
            status: store['status'],
            storeTags: store['storeTags'],
            category: store['category'],
            distance: store['distance'],
          ));
        }
        notifyListeners();
      } else if (response.statusCode != 200) {
        fetchStatus = false;

        print("this is the status code");
        print(response.statusCode);
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
