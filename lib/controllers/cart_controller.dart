import 'package:dash_user_app/data/repository/cart_repo.dart';
import 'package:dash_user_app/model/cart_model.dart';
import 'package:dash_user_app/model/item_model.dart';
import 'package:dash_user_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;
  /*
  only for storage and shared preferences
  */
  List<CartModel> storageItems = [];

  void addItem(Item item, int quantity) {
    var totalQuantity = 0;
    print(item);
    // if (_items.containsKey(item.items.)) {
    //   _items.update(int.parse(item.id!), (value) {
    //     totalQuantity = value.quantity! + quantity;

    //     return CartModel(
    //       id: value.id,
    //       price: value.price,
    //       name: value.name,
    //       img: value.img,
    //       isExist: true,
    //       quantity: value.quantity! + quantity,
    //       time: DateTime.now().toString(),
    //       item: item,
    //     );
    //   });

    //   if (totalQuantity <= 0) {
    //     _items.remove(item.id);
    //   }
    // } else {
    //   if (quantity > 0) {
    //     _items.putIfAbsent(int.parse(item.id!), () {
    //       return CartModel(
    //         id: int.parse(item.id!),
    //         name: item.itemName,
    //         price: int.parse(item.price!),
    //         img: item.itemImage,
    //         quantity: quantity,
    //         isExist: true,
    //         time: DateTime.now().toString(),
    //         item: item,
    //       );
    //     });
    //   } else {
    //     Get.snackbar("Empty cart", "Please add atleast an item in cart",
    //         backgroundColor: AppColors.mainColor, colorText: Colors.white);
    //   }
    // }
    cartRepo.addToCartList(getItems);
    update();
  }

  // bool existInCart(Item item) {
  //   if (_items.containsKey(item.id)) {
  //     return true;
  //   }
  //   return false;
  // }

  // int getQuantity(Items item) {
  //   var quantity = 0;
  //   if (_items.containsKey(item.id)) {
  //     _items.forEach((key, value) {
  //       if (key == item.id) {
  //         quantity = value.quantity!;
  //       }
  //     });
  //   }
  //   return quantity;
  // }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    return storageItems;
  }
}
