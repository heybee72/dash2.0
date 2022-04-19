import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dash_user_app/new_models/signup_model.dart';
import 'package:http/http.dart' as http;

import 'store_model.dart';

String base_url = 'https://dash.toptechng.com/api';

Future<http.Response?> register(SignUpBody data) async {
  http.Response? response;
  try {
    response = await http.post(
      Uri.parse("${base_url}/user/register"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(
        data.toJson(),
      ),
    );
  } catch (e) {
    print(e);
    log(e.toString());
  }
  return response;
}

Future<StoreModel?> getStoresAvaialable(
    {required lat, required lng, required cat}) async {
  StoreModel? store;
  try {
    final response = await http.get(
      Uri.parse("${base_url}/user/fetchStores/$lat/$lng/$cat"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // store = StoreModel.fromJson(json.decode(response.body));
      final item = json.decode(response.body);
      store = StoreModel.fromJson(item);
   
    } else {
      print("response.statusCode");
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
    log(e.toString());
  }
  return store;
}
