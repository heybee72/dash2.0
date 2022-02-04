import 'package:flutter/material.dart';

class Store with ChangeNotifier {
  final String id;
  final String storeName;
  final String storeImage;
  final List<String> storeTags;
  final bool isAvailable;
  final String storeAddress;
  final double storeLatitude;
  final double? storeLongitude;

  Store({
    required this.id,
    required this.storeName,
    required this.storeImage,
    required this.storeTags,
    required this.isAvailable,
    required this.storeAddress,
    required this.storeLatitude,
    required this.storeLongitude,
  });
}

class StoreProvider with ChangeNotifier {
  List<Store> _stores = [
    Store(
      id: 'store1',
      isAvailable: true,
      storeAddress: '3, Ojuolape Street, Ojo, Lagos',
      storeImage: './assets/category_food.jpg',
      storeName: 'KFC',
      storeTags: ['Fries', 'Burger', 'Pizza'],
      storeLatitude: 3.222,
      storeLongitude: 4.222,
    ),
    Store(
      id: 'store2',
      isAvailable: true,
      storeAddress: '3, Ojuolape Street, Ojo, Lagos',
      storeImage: './assets/category_food.jpg',
      storeName: 'Chicken Republic',
      storeTags: ['Fries', 'Burger', 'Pizza'],
      storeLatitude: 3.222,
      storeLongitude: 4.222,
    ),
    Store(
      id: 'store3',
      isAvailable: true,
      storeAddress: '3, Ojuolape Street, Ojo, Lagos',
      storeImage: './assets/category_food.jpg',
      storeName: 'Iya Yusuf',
      storeTags: ['Fries', 'Burger', 'Pizza'],
      storeLatitude: 3.222,
      storeLongitude: 4.222,
    ),
    Store(
      id: 'store4',
      isAvailable: true,
      storeAddress: '3, Ojuolape Street, Ojo, Lagos',
      storeImage: './assets/category_food.jpg',
      storeName: 'Item 7',
      storeTags: ['Fries', 'Burger', 'Pizza'],
      storeLatitude: 3.222,
      storeLongitude: 4.222,
    ),
    Store(
      id: 'store5',
      isAvailable: true,
      storeAddress: '3, Ojuolape Street, Ojo, Lagos',
      storeImage: './assets/category_food.jpg',
      storeName: 'T & K',
      storeTags: ['Fries', 'Burger', 'Pizza'],
      storeLatitude: 3.222,
      storeLongitude: 4.222,
    ),
    Store(
      id: 'store6',
      isAvailable: true,
      storeAddress: '3, Ojuolape Street, Ojo, Lagos',
      storeImage: './assets/category_food.jpg',
      storeName: 'Charcoal',
      storeTags: ['Fries', 'Burger', 'Pizza'],
      storeLatitude: 3.222,
      storeLongitude: 4.222,
    ),
  ];

  List<Store> stores() {
    return _stores;
  }

  Store getById(String storeId) {
    return _stores.firstWhere((element) => element.id == storeId);
  }

  
}
