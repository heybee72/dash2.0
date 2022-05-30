import 'package:dash_user_app/controllers/store_param_controller.dart';
import 'package:dash_user_app/data/api/api_client.dart';
import 'package:dash_user_app/utils/app_constants.dart';
import 'package:get/get.dart';

import 'store_param_repo.dart';

class StoreRepo extends GetxService {
  final ApiClient apiClient;
  final StoreParamRepo storeParamRepo;

  StoreRepo({required this.apiClient, required this.storeParamRepo});

  Future<Response> getStoreList(lat, lng, cat) async {
    var param = Get.find<StoreParamController>().storeParamRepo;
    return await apiClient.getData(AppConstant.FETCH_STORE_URI +
        '/' +
        lat.toString() +
        '/' +
        lng.toString() +
        '/' +
        cat.toString());
  }
}
