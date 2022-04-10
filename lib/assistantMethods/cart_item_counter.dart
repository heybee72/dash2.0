import 'package:dash_user_app/global/global.dart';
import 'package:flutter/material.dart';

class CartItemCounter extends ChangeNotifier {
  int cartListItemcounter =
      sharedPreferences!.getStringList("userCart")!.length;
  int get count => cartListItemcounter;
  Future<void> displaycartListItemNumber() async {
    cartListItemcounter = sharedPreferences!.getStringList("userCart")!.length;
    await Future.delayed(Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
