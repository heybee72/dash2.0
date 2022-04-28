import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class SignUpBody {
  String uid;
  String storeName;
  String storeEmail;
  String storePhone;
  String password;
  double lat;
  double lng;
  String storeLocation;
  String storeImage;
  String storeTags;
  String category;

  SignUpBody({
    required this.uid,
    required this.storeName,
    required this.storeEmail,
    required this.storePhone,
    required this.password,
    required this.lat,
    required this.lng,
    required this.storeLocation,
    required this.storeImage,
    required this.storeTags,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeName'] = this.storeName;
    data['storeEmail'] = this.storeEmail;
    data['storePhone'] = this.storePhone;
    data['password'] = this.password;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['storeLocation'] = this.storeLocation;
    data['storeImage'] = this.storeImage;
    data['storeTags'] = this.storeTags;
    data['category'] = this.category;

    return data;
  }
}

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
