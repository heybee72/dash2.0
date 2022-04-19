

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class Store with ChangeNotifier {
  final String id;
  final String storeName;
  final String storeImage;
  final Map<dynamic, dynamic> storeTags;
  final bool isAvailable;
  final String storeAddress;
  final double storeLatitude;
  final double? storeLongitude;

  Store({
    required this.id,
    required this.storeName,
    required this.storeImage,
    required this.storeTags,
    required this.isAvailable,
    required this.storeAddress,
    required this.storeLatitude,
    required this.storeLongitude,
  });
}

class StoreProvider with ChangeNotifier {
  List<Store> _stores = [];
    List<Store> get stores {
    return [..._stores];
  }

  Future<void> fetchStores() async {
    double lng;
    double lat;
    final geo = Geoflutterfire();
    final _firestore = FirebaseFirestore.instance;
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;
      var _uid = user!.uid;
      final DocumentSnapshot userDocs =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      lng = userDocs.get('lng');
      lat = userDocs.get('lat');

      // Create a geoFirePoint
      GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
      var collectionReference = _firestore.collection('stores');
      double radius = 5;
      String field = 'position';

      Stream<List<DocumentSnapshot>> stream = geo
          .collection(collectionRef: collectionReference)
          .within(center: center, radius: radius, field: field);

      // print("streamed data");
      // print(stream.toList());
      stream.listen((List<DocumentSnapshot> documentList) {
        _stores = [];
        documentList.forEach((DocumentSnapshot document) {
          final data = document.data() as Map<String, dynamic>;

          _stores.insert(
              0,
              Store(
                id: data['storeUID'],
                isAvailable: true,
                storeAddress: data['storeLocation'],
                storeImage: data['storeImageUrl'],
                storeLatitude: data['lat'],
                storeLongitude: data['lng'],
                storeName: data['storeName'],
                storeTags: data['storeTags'],
              ));
        });
      });


    } catch (e) {
      print("this is an error::: $e");
    }
  }

  // List<Store> stores() {
  //   return _stores;
  // }

  Store getById(String storeId) {
    return _stores.firstWhere((element) => element.id == storeId);
  }
}

