import 'package:flutter/material.dart';

class ItemCategory with ChangeNotifier {
  final String itemCatId;
  final String storeId;
  final String itemName;
  final bool isAvailable;

  ItemCategory(
      {required this.itemCatId,
      required this.storeId,
      required this.itemName,
      required this.isAvailable});
}

class ItemCategoryProvider with ChangeNotifier {
  List<ItemCategory> _itemCategories = [
    ItemCategory(
      itemCatId: 'itemCat1',
      storeId: 'store1',
      itemName: 'Combo 1',
      isAvailable: true,
    ),
    ItemCategory(
      itemCatId: 'itemCat2',
      storeId: 'store1',
      itemName: 'Combo 2',
      isAvailable: true,
    ),
    ItemCategory(
      itemCatId: 'itemCat3',
      storeId: 'store3',
      itemName: 'Combo 3',
      isAvailable: true,
    ),
    ItemCategory(
      itemCatId: 'itemCat4',
      storeId: 'store1',
      itemName: 'Combo 4',
      isAvailable: true,
    ),
  ];

  List<ItemCategory> get items {
    return _itemCategories;
  }

  List<ItemCategory> fetchItemCategorysByStore(String storeId) {
    List<ItemCategory> itemList = _itemCategories
        .where(
            (element) => element.storeId.toLowerCase() == storeId.toLowerCase())
        .toList();
    return itemList;
  }

  ItemCategory getById(String itemCatId) {
    return _itemCategories
        .firstWhere((element) => element.itemCatId == itemCatId);
  }

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
