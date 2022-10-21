// import 'package:dash_user_app/assistantMethods/cart_item_counter.dart';
// import 'package:dash_user_app/assistantMethods/total_amount.dart';
// import 'package:dash_user_app/screens/innerScreens/store_details.dart';
import 'package:dash_user_app/routes/route_helper.dart';
import 'package:dash_user_app/screens/store/_store_details.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// import 'dataHandler/app_data.dart';

// import 'models&providers/cart.dart';
// import 'models&providers/item_category.dart';
// import 'models&providers/item.dart';
// import 'models&providers/store.dart';
import 'controllers/items_controller.dart';
import 'controllers/store_controller.dart';
import 'model/data_class.dart';
// import 'new_provider/store_provider.dart';
import 'screens/auth/auth_state_screen.dart';
import 'screens/auth/choose_path.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/get_phone_number_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/verify_phone_number.dart';
import 'screens/bottom_nav_screen.dart';
import 'screens/home_screen.dart';
import 'helper/dependencies.dart' as dep;
import 'screens/innerScreens/choose_category.dart';
import 'screens/innerScreens/choose_location.dart';
import 'screens/landing_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Permission permission;
  PermissionStatus permissionStatus = PermissionStatus.denied;
  void listenForPermission() async {
    final status = await Permission.location.status;
    setState(() {
      permissionStatus = status;
    });
    switch (status) {
      case PermissionStatus.denied:
        requestForPermissions();
        break;

      case PermissionStatus.restricted:
        Navigator.pop(context);

        break;
      case PermissionStatus.limited:
        Navigator.pop(context);

        break;
      case PermissionStatus.permanentlyDenied:
        Navigator.pop(context);

        break;
      case PermissionStatus.granted:
        break;
    }
  }

  Future<void> requestForPermissions() async {
    final status = await Permission.location.request();
    setState(() {
      permissionStatus = status;
    });
  }

  initState() {
    super.initState();
    listenForPermission();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ItemController>();
    Get.find<StoreController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'EuclidCircularB',
        primaryColor: Constants.primary_color,
        buttonTheme: const ButtonThemeData(
          buttonColor: Constants.secondary_color,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      title: 'Dash',
      home: BottomNavScreen(),
      // home: AuthStateScreen(),
      getPages: RouteHelper.routes,
      routes: {
        LandingScreen.routeName: (ctx) => LandingScreen(),
        ChoosePath.routeName: (ctx) => ChoosePath(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
        GetPhoneNumberScreen.routeName: (ctx) => GetPhoneNumberScreen(),
        VerifyPhoneNumber.routeName: (ctx) => VerifyPhoneNumber(),
        ChooseLocation.routeName: (ctx) => ChooseLocation(),
        ChooseCategory.routeName: (ctx) => ChooseCategory(),
        // StoreDetailScreen.routeName: (ctx) => StoreDetailScreen(pageId: null,),
        // ItemDetailsScreen.routeName: (ctx) => ItemDetailsScreen(),
        BottomNavScreen.routeName: (ctx) => BottomNavScreen(),
        // HomeScreen.routeName: (ctx) => HomeScreen(),
        // SearchScreen.routeName: (ctx) => SearchScreen(),
        // OrdersScreen.routeName: (ctx) => OrdersScreen(index: 0),
        // ProfileScreen.routeName: (ctx) => ProfileScreen(),
        // Profile.routeName: (ctx) => Profile(),
        // CartScreen.routeName: (ctx) => CartScreen(),
        // CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
      },
    );
  }
}
