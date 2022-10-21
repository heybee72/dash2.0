import 'package:dash_user_app/data/repository/item_repo.dart';
import 'package:dash_user_app/model/item_model.dart';
import 'package:dash_user_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cart_controller.dart';

class ItemController extends GetxController {
  final ItemRepo itemRepo;
  ItemController({required this.itemRepo});

  late CartController _cart;

  int _catLength = 0;
  int get catLength => _catLength;

  List _itemList = [];
  List get itemList => _itemList;
  List _cat = [];
  List get cat => _cat;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _itemFound = true;
  bool get itemFound => _itemFound;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getItemList(uid) async {
    _itemList = [];
    _cat = [];
    _catLength = 0;
    // _items = [];
    Response response = await itemRepo.getItemList(uid);

    if (response.statusCode == 200) {
      _catLength = response.body.length;
      for (var i = 0; i < response.body.length; i++) {
        // update();
        
        _cat.add(response.body[i]['cat']['title']);
        _itemList.add(response.body[i]['cat']['content']);
      }
 
      // for (var j = 0; j < response.body.length; j++) {
      //   // print(response.body[0]['items'][j]);
      //   _itemList.add(response.body[j]['items']);
      //   print("_itemList");
      //   print(_itemList);
      // }

      _itemFound = true;
      _isLoaded = true;
      update();
    } else if (_itemList.isEmpty) {
      _itemFound = false;
      _isLoaded = true;
      update();
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item Count",
        "Item Count cannot be less than 0",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      // this is nimber of quantity coming from the server
      Get.snackbar("Item Count", "Item Count cannot be more than 20",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);

      return 20;
    } else {
      return quantity;
    }
  }

  // void initProduct(Item item, CartController cart) {
  //   _quantity = 0;
  //   _inCartItems = 0;
  //   _cart = cart;
  //   var exist = false;
  //   exist = _cart.existInCart(item);
  //   // if exists
  //   //  get from storage _inCartItems = 3

  //   if (exist) {
  //     _inCartItems = _cart.getQuantity(item);
  //   }
  // }

  // void addItem(Item item) {
  //   print("item added");
  //   print(item);
  //   _cart.addItem(item, _quantity);
  //   _quantity = 0;

  //   _inCartItems = _cart.getQuantity(item);

  //   _cart.items.forEach((key, value) {
  //     print("Item Added" +
  //         value.name! +
  //         " and the quantity is:" +
  //         value.quantity.toString());
  //   });

  //   update();
  // }

  int get totalItems {
    return _cart.totalItems;
  }

  // List<Items> get getItems {
  //   return _cart.getItems;
  // }
}
