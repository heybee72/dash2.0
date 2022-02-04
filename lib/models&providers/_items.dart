import 'package:flutter/material.dart';

class Item with ChangeNotifier {
  final String itemId;
  final String itemCatId;
  final String itemTitle;
  final String itemDescription;
  final String itemPrice;
  final String itemImage;
  final bool isAvailable;

  Item(
      {required this.itemId,
      required this.itemCatId,
      required this.itemTitle,
      required this.itemDescription,
      required this.itemPrice,
      required this.itemImage,
      required this.isAvailable});
}

class ItemProvider with ChangeNotifier {
  List<Item> _items = [
    Item(
      itemId: 'item1',
      itemCatId: 'itemCat1',
      itemTitle: '5-1n 1 ',
      itemDescription: '5-1n 1 ',
      itemPrice: '7500',
      itemImage: 'assets/category_food.jpg',
      isAvailable: true,
    ),
    Item(
      itemId: 'item2',
      itemCatId: 'itemCat1',
      itemTitle: '5-1n 2',
      itemDescription: '5-1n 1 ',
      itemPrice: '7500',
      itemImage: 'assets/category_food.jpg',
      isAvailable: true,
    ),
  ];

  List<Item> get items {
    return _items;
  }

  // List<Item> fetchItemsByItemCat(String storeId) {
  //   List<Item> itemList = _items
  //       .where(
  //           (element) => element.storeId.toLowerCase() == storeId.toLowerCase())
  //       .toList();
  //   return itemList;
  // }

  // Item getById(String itemId) {
  //   return _items.firstWhere((element) => element.itemId == itemId);
  // }

  // void addItem(Item item) {
  //   _items.add(item);
  //   notifyListeners();
  // }

  // void updateItem(Item item) {
  //   final itemIndex = _items.indexWhere((item) => item.itemId == item.itemId);
  //   _items[itemIndex] = item;
  //   notifyListeners();
  // }

  // void deleteItem(String id) {
  //   _items.removeWhere((item) => item.itemId == id);
  //   notifyListeners();
  // }
}
