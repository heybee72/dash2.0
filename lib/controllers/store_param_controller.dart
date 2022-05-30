import 'package:dash_user_app/data/repository/store_param_repo.dart';
import 'package:dash_user_app/model/store_param.dart';
import 'package:get/get.dart';

class StoreParamController extends GetxController {
  final StoreParamRepo storeParamRepo;
  StoreParamController({required this.storeParamRepo});

  Map<int, StoreParamModel> _params = {};

  Map<int, StoreParamModel> get params => _params;

  void addParam(address, lat, lng, category) {
    _params = {};
    _params.putIfAbsent(1, () {
      return StoreParamModel(
        id: 1,
        address: address,
        latitude: lat,
        longitude: lng,
        category: category,
      );
    });
    print(_params.values.toList()[0].address);
    storeParamRepo.addToParam(address, lat, lng);
    update();
  }

  void updateParam(category) {
    _params.update(1, (value) {
      print("value.address");
      print(value.address);
      print(value.latitude);

      return StoreParamModel(
        id: 1,
        address: value.address,
        latitude: value.latitude,
        longitude: value.longitude,
        category: category,
      );
    });
    storeParamRepo.updateToParam(category);
    update();
  }

  String getParamAddress() {
    String address = "";

    if (storeParamRepo.sharedPreferences.containsKey("address")) {
      storeParamRepo.sharedPreferences.getString("address");
      address = storeParamRepo.sharedPreferences.getString("address")!;

      print(address.toString());
    } else {
      address = "Enter Address";
    }

    return address;
  }

  double getParamLatitude() {
    double latitude = 0.0;

    if (storeParamRepo.sharedPreferences.containsKey("latitude")) {
      storeParamRepo.sharedPreferences.getDouble("latitude");
      latitude = storeParamRepo.sharedPreferences.getDouble("latitude")!;

      print(latitude);
    } else {
      latitude = 0.0;
    }

    return latitude;
  }

  double getParamLongitude() {
    double longitude = 0.0;

    if (storeParamRepo.sharedPreferences.containsKey("longitude")) {
      storeParamRepo.sharedPreferences.getDouble("longitude");
      longitude = storeParamRepo.sharedPreferences.getDouble("longitude")!;

      print(longitude);
    } else {
      longitude = 0.0;
    }

    return longitude;
  }

  String getParamCategory() {
    String category = "";

    if (storeParamRepo.sharedPreferences.containsKey("category")) {
      storeParamRepo.sharedPreferences.getString("category");
      category = storeParamRepo.sharedPreferences.getString("category")!;

      print(category.toString());
    } else {
      category = "Select Category";
    }
    return category;
  }
}
