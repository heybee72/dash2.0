import 'package:dash_user_app/controllers/cart_controller.dart';
import 'package:dash_user_app/controllers/items_controller.dart';
import 'package:dash_user_app/controllers/store_controller.dart';
import 'package:dash_user_app/controllers/store_param_controller.dart';
import 'package:dash_user_app/data/api/api_client.dart';
import 'package:dash_user_app/data/repository/cart_repo.dart';
import 'package:dash_user_app/data/repository/item_repo.dart';
import 'package:dash_user_app/data/repository/store_param_repo.dart';
import 'package:dash_user_app/data/repository/store_repo.dart';
import 'package:dash_user_app/utils/app_constants.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(
    () => ApiClient(appBaseUrl: AppConstant.BASE_URL),
  );

// repositories
  Get.lazyPut(() => StoreParamRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => StoreRepo(apiClient: Get.find(), storeParamRepo: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  Get.lazyPut(() => ItemRepo(apiClient: Get.find()));

  // controllers
  Get.lazyPut(() => StoreParamController(storeParamRepo: Get.find()));
  Get.lazyPut(
      () => StoreController(storeParamRepo: Get.find(), storeRepo: Get.find()));
  Get.lazyPut(() => ItemController(itemRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
