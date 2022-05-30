import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dash_user_app/model/signup_model.dart';
import 'package:http/http.dart' as http;

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
