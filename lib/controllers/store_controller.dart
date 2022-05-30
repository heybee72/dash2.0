import 'package:dash_user_app/data/repository/store_param_repo.dart';
import 'package:dash_user_app/data/repository/store_repo.dart';
import 'package:dash_user_app/model/store_model.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  final StoreRepo storeRepo;
  final StoreParamRepo storeParamRepo;

  StoreController({required this.storeRepo, required this.storeParamRepo});

  List<dynamic> _storeList = [];
  List<dynamic> get storeList => _storeList;

  bool _isLoaded = false;
  bool _storeFound = true;
  bool get isLoaded => _isLoaded;
  bool get storeFound => _storeFound;

  Future<void> getStoreList() async {
    _storeList = [];
    double lat = storeParamRepo.getParamLatitude();
    double lng = storeParamRepo.getParamLongitude();
    String cat = storeParamRepo.getParamCategory();
    Response response = await storeRepo.getStoreList(lat, lng, cat);

    if (response.statusCode == 200) {
      _storeList = [];
      _storeList.addAll(Store.fromJson(response.body).stores);
      _isLoaded = true;
      _storeFound = true;
      update();
    } else if (response.statusCode == 404) {
      _storeList = [];
      _isLoaded = true;
      _storeFound = false;
      update();
    }
  }
}
