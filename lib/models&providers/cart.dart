import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  final String cartId;
  final String itemId;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  Cart({
    required this.cartId,
    required this.itemId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartList = {};

  Map<String, Cart> get cartList {
    return _cartList;
  }

  double get totalAmount {
    double total = 0.0;
    _cartList.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  Future<bool> addToCart(String title, String itemId, String imageUrl,
      double price, int quantity) async {
    if (_cartList.containsKey(itemId)) {
      _cartList.update(
        itemId,
        (value) => Cart(
          cartId: value.cartId,
          title: value.title,
          imageUrl: value.imageUrl,
          price: value.price,
          quantity: value.quantity + quantity,
          itemId: value.itemId,
        ),
      );

      notifyListeners();
      return true;
    } else {
      _cartList.putIfAbsent(
        itemId,
        () => Cart(
          cartId: DateTime.now().toIso8601String(),
          title: title,
          imageUrl: imageUrl,
          price: price,
          quantity: quantity,
          itemId: itemId,
        ),
      );
    }
    notifyListeners();
    // print("respose from map print ${_cartList.values.toList()}");

    return true;
  }

  void decrementCartProductQuantity({
    String? cartId,
    required String itemId,
    String? title,
    int? quantity,
    String? imageUrl,
    double? price,
  }) {
    if (_cartList.containsKey(itemId)) {
      _cartList.update(
        itemId,
        (value) => Cart(
          cartId: value.cartId,
          itemId: itemId,
          title: value.title,
          quantity: value.quantity - 1,
          imageUrl: value.imageUrl,
          price: value.price,
        ),
      );
    }
    notifyListeners();
  }

  // int get itemCount {
  //   return _items.length;
  // }

  void removeItem(String pId) {
    _cartList.remove(pId);
    notifyListeners();
  }

  void clearCart() {
    _cartList.clear();
    notifyListeners();
  }
}
