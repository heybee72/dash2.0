
import 'package:dash_user2/models/address.dart';
import 'package:dash_user2/models/category.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation, dropOffLocation;

  Category? selectedCategory;

  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateSelectedCategory(Category selectedCategory) {
    selectedCategory = selectedCategory;
    notifyListeners();
  }

  // void updateDropOffLocationAddress(Address dropOffAddress) {
  //   dropOffLocation = dropOffAddress;
  //   notifyListeners();
  // }
}
