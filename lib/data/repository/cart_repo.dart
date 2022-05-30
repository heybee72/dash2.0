import 'dart:convert';

import 'package:dash_user_app/model/cart_model.dart';
import 'package:dash_user_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    /*
      convert object to string because shared preferences only accepts string...
    */
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstant.CART_LIST, cart);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstant.CART_LIST)) {
      sharedPreferences.getStringList(AppConstant.CART_LIST);
      carts = sharedPreferences.getStringList(AppConstant.CART_LIST)!;

      print(carts.toString());
    }
    List<CartModel> cartList = [];

    carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }
}
