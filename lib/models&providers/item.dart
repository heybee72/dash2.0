import 'package:flutter/material.dart';

class Item with ChangeNotifier {
  final String itemId;
  final String storeId;
  final String itemName;
  final List<Map> storeItems;
  final bool isAvailable;

  Item(
      {required this.itemId,
      required this.storeId,
      required this.itemName,
      required this.storeItems,
      required this.isAvailable});
}

class ItemProvider with ChangeNotifier {
  List<Item> _items = [
    Item(
      itemId: 'item1',
      storeId: 'BbKM7nsZYZbNLYL1KY8RQ3Smbs53',
      itemName: 'Combo 1',
      storeItems: [
        {
          'id': '1',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '7500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '2',
          'title': '5-1n 2 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '3500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '3',
          'title': '5-1n 3 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '2500',
          'image': 'assets/category_food.jpg'
        },
        // {
        //   'title': '5-1n 1 ',
        //   'description':
        // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
        //   'price': '2500',
        //   'image': 'assets/category_food.jpg'
        // },
      ],
      isAvailable: true,
    ),
    Item(
      itemId: 'item2',
      storeId: 'BbKM7nsZYZbNLYL1KY8RQ3Smbs53',
      itemName: 'Combo 2',
      storeItems: [
        {
          'id': '4',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '2500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '5',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '2500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '6',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '2500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '7',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '2500',
          'image': 'assets/category_food.jpg'
        },
      ],
      isAvailable: true,
    ),
    Item(
      itemId: 'item3',
      storeId: 'BbKM7nsZYZbNLYL1KY8RQ3Smbs54',
      itemName: 'Combo 3',
      storeItems: [
        {
          'id': '8',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '1500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '9',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '3500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '10',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '2500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '11',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '2500',
          'image': 'assets/category_food.jpg'
        },
      ],
      isAvailable: true,
    ),
    Item(
      itemId: 'item4',
      storeId: 'BbKM7nsZYZbNLYL1KY8RQ3Smbs53',
      itemName: 'Combo 4',
      storeItems: [
        {
          'id': '12',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '22500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '13',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '2500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '14',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '4500',
          'image': 'assets/category_food.jpg'
        },
        {
          'id': '15',
          'title': '5-1n 1 ',
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
          'price': '2500',
          'image': 'assets/category_food.jpg'
        },
      ],
      isAvailable: true,
    ),
  ];

  List<Item> get items {
    return _items;
  }

  List<Item> fetchItemsByStore(String storeId) {
    List<Item> itemList = _items
        .where(
            (element) => element.storeId.toLowerCase() == storeId.toLowerCase())
        .toList();
    return itemList;
  }

  Item getById(String itemId) {
    return _items.firstWhere((element) => element.itemId == itemId);
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
