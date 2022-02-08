import 'package:dash_user2/errand/screen2.dart';
import 'package:dash_user2/screens/auth/forgot_password_screen.dart';
import 'package:dash_user2/screens/auth/login_screen.dart';
import 'package:dash_user2/screens/auth/register_screen.dart';
import 'package:dash_user2/screens/auth/verify_phone_number.dart';
import 'package:dash_user2/screens/home_screen.dart';
import 'package:dash_user2/screens/innerScreens/cart_screen.dart';
import 'package:dash_user2/screens/innerScreens/select_location.dart';
import 'package:dash_user2/screens/innerScreens/store_details.dart';
import 'package:dash_user2/screens/orders_screen.dart';
import 'package:dash_user2/screens/profile_screen.dart';
import 'package:dash_user2/screens/search_screen.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:dash_user2/widgets/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dataHandler/appData.dart';
import 'errand/screen1.dart';
import 'errand/screen3.dart';
import 'models&providers/cart.dart';
import 'models&providers/item_category.dart';
import 'models&providers/items.dart';
import 'models&providers/store.dart';
import 'screens/auth/auth_stream.dart';
import 'screens/auth/choose_path.dart';
import 'screens/bottom_nav_screen.dart';
import 'screens/innerScreens/choose_category.dart';
import 'screens/innerScreens/item_details_screen.dart';
import 'screens/landing_screen.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => StoreProvider()),
        ChangeNotifierProvider(create: (ctx) => ItemCategoryProvider()),
        ChangeNotifierProvider(create: (ctx) => ItemProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(
            create: (ctx) => Cart(
                cartId: '',
                imageUrl: '',
                itemId: '',
                price: 0,
                quantity: 1,
                title: '')),
      ],
      child: ChangeNotifierProvider(
        create: (context) => AppData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'EuclidCircularB',
            primaryColor: Constants.primary_color,
            buttonTheme: ButtonThemeData(
              buttonColor: Constants.secondary_color,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          title: 'Dash',
          home: AuthStateScreen(),
          routes: {
            LandingScreen.routeName: (ctx) => LandingScreen(),
            ChoosePath.routeName: (ctx) => ChoosePath(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            RegisterScreen.routeName: (ctx) => RegisterScreen(),
            ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
            VerifyPhoneNumber.routeName: (ctx) => VerifyPhoneNumber(),
            ChooseLocation.routeName: (ctx) => ChooseLocation(),
            ChooseCategory.routeName: (ctx) => ChooseCategory(),
            StoreDetailScreen.routeName: (ctx) => StoreDetailScreen(),
            ItemDetailsScreen.routeName: (ctx) => ItemDetailsScreen(),
            BottomNavScreen.routeName: (ctx) => BottomNavScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SearchScreen.routeName: (ctx) => SearchScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(index: 0),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            Profile.routeName: (ctx) => Profile(),
            CartScreen.routeName: (ctx) => CartScreen(),
          },
        ),
      ),
    );
  }
}
