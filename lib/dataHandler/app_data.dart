
import 'package:dash_user_app/models/address.dart';
import 'package:dash_user_app/models/category.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  Address? deliveryLocation;

  Category? selectedCategory;

  void updateDeliveryLocationAddress(Address deliveryAddress) {
    deliveryLocation = deliveryAddress;
    notifyListeners();
  }

  void updateSelectedCategory(Category selectedCategory) {
    selectedCategory = selectedCategory;
    notifyListeners();
  }


}
