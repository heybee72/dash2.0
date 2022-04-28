import 'package:dash_store/new_model/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataClass extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  Future<void> postData(SignUpBody body) async {
    loading = true;
    notifyListeners();
    http.Response response = (await register(body))!;

    if (response.statusCode == 200) {
      isBack = true;
    }
    loading = false;
    notifyListeners();
  }
}

// class StoreClass extends ChangeNotifier {
//   StoreModel? store;
//   bool loading = false;

//   getStoreData() async {
//     loading = true;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? prefCat = prefs.getString('prefCat');
//     double? selected_lat = prefs.getDouble('selected_lat');
//     double? selected_lng = prefs.getDouble('selected_lng');

//     store = (await getStoresAvaialable(
//         cat: prefCat, lat: selected_lat, lng: selected_lng))!;
//     loading = false;

//     notifyListeners();
//   }
// }
