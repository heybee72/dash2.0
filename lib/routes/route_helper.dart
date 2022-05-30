import 'package:dash_user_app/screens/bottom_nav_screen.dart';
import 'package:dash_user_app/screens/store/item_details_screen.dart';
import 'package:dash_user_app/screens/store/store_details.dart';
import 'package:get/get.dart';

class RouteHelper {
  // static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String singleStore = "/single-store";
  static const String itemDetail = "/item-details";
  // static const String cartPage = "/cart-page";

  // static String getSplashPage() => "$splashPage";
  static String getInitial() => "$initial";

  static String getSingleStore(int pageId, String uid) =>
      '$singleStore?pageId=$pageId&uid=$uid';
  static String getItemDetails(int pageId, itemListIndex) =>
      '$itemDetail?pageId=$pageId&itemListIndex=$itemListIndex';
  // static String getCartPage() => "$cartPage";

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => BottomNavScreen()),

    GetPage(
      name: singleStore,
      page: () {
        var pageId = Get.parameters["pageId"];
        String uid = Get.parameters["uid"].toString();
        return StoreDetailScreen(
          pageId: int.parse(pageId!),
          uid: uid,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: itemDetail,
      page: () {
        var pageId = Get.parameters["pageId"];
        var itemListIndex = Get.parameters["itemListIndex"];
        return ItemDetailsScreen(
            pageId: int.parse(pageId!),
            itemListIndex: int.parse(itemListIndex!));
      },
      transition: Transition.fadeIn,
    ),
    // GetPage(
    //   name: cartPage,
    //   page: () {
    //     return CartPage();
    //   },
    //   transition: Transition.fadeIn,
    // ),
  ];
}
