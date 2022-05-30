import 'package:dash_user_app/data/api/api_client.dart';
import 'package:dash_user_app/utils/app_constants.dart';
import 'package:get/get.dart';

class ItemRepo extends GetxService {
  final ApiClient apiClient;

  ItemRepo({required this.apiClient});

  Future<Response> getItemList(uid) async {
    return await apiClient
        .getData(AppConstant.FETCH_ITEM_URI + '/' + uid.toString());
  }
}
