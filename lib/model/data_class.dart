import 'package:dash_user_app/model/service_class.dart';
import 'package:dash_user_app/model/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'store_model.dart';

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
