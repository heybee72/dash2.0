import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user_app/assistantMethods/assistant_methods.dart';
import 'package:dash_user_app/assistantMethods/cart_item_counter.dart';
import 'package:dash_user_app/assistantMethods/total_amount.dart';
import 'package:dash_user_app/global/global.dart';
import 'package:dash_user_app/model/itemz.dart';
import 'package:dash_user_app/model/menu.dart';
import 'package:dash_user_app/models&providers/cart.dart';
import 'package:dash_user_app/models&providers/item.dart';
import 'package:dash_user_app/models&providers/store.dart';
import 'package:dash_user_app/screens/innerScreens/cart_screen.dart';
import 'package:dash_user_app/services/global_methods.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/widgets/info_design.dart';
import 'package:dash_user_app/widgets/meals.dart';
import 'package:dash_user_app/widgets/progress_bar.dart';
import 'package:dash_user_app/widgets/view_categories.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item_details_screen.dart';

class StoreDetailScreen extends StatefulWidget {
  static const String routeName = 'store-detail-screen';

  const StoreDetailScreen({Key? key}) : super(key: key);
  @override
  StoreDetailScreenState createState() => StoreDetailScreenState();
}

class StoreDetailScreenState extends State<StoreDetailScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    sharedPreferences!.reload();
  }

  @override
  Widget build(BuildContext context) {
    final storeId = ModalRoute.of(context)!.settings.arguments as String;

    final storeProvider = Provider.of<StoreProvider>(context);

    final itemProvider = Provider.of<ItemProvider>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();

    final store = storeProvider.getById(storeId);

    final _item = itemProvider.fetchItemsByStore(storeId);

    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        await globalMethods.showDialogue(context, () => clearCartNow(context));
        return willLeave;
      },
      child: storeDetailView(
          globalMethods, cartProvider, store, size, storeId, context),
    );
  }

  Widget storeDetailView(GlobalMethods globalMethods, CartProvider cartProvider,
      Store store, Size size, String storeId, BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            DefaultTabController(
              length: 0,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: InkWell(
                        onTap: () async {
                          globalMethods.showDialogue(
                              context, () => clearCartNow(context));
                        },
                        // onTap: () => globalMethods.showDialogue(context, ()=>cartProvider.clearCart());

                        // onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_outlined),
                      ),
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      expandedHeight: 300.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        double height = constraints.biggest.height;
                        return Stack(
                          children: [
                            Positioned(
                                child: Stack(
                                  children: [
                                    Container(
                                      color: Constants.primary_color,
                                    ),
                                    Opacity(
                                      opacity: .5,
                                      child: Image.network(
                                        "${store.storeImage}",
                                        width: size.width,
                                        height: 300.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Center(
                                        child: Text(
                                      "${store.storeName}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    )),
                                    Center(
                                      heightFactor: 35,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 50.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              _getTags(store.storeTags),
                                            ]),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: size.height * .1,
                                      right: 10.0,
                                      child: Text("10 - 15 mins",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                                    )
                                  ],
                                ),
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0),
                            Positioned(
                              child: Container(
                                  padding:
                                      EdgeInsets.only(left: 16.0, right: 21.0),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: height < 100
                                        ? BorderRadius.zero
                                        : BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                  ),
                                  child: height < 100
                                      ? Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: IconButton(
                                                  icon: Icon(Icons.arrow_back),
                                                  color:
                                                      Constants.primary_color,
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                width: size.width * .5,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${store.storeName}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Constants
                                                          .primary_color,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () {
                                            // Navigator.of(context).pushNamed(
                                            //     StoreInfo.idScreen,
                                            //     arguments: store.id);
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "Restaurant info",
                                                style: TextStyle(
                                                    color:
                                                        Constants.primary_color,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Expanded(child: Container()),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color(0XFFC4C4C4),
                                                size: 14.0,
                                              )
                                            ],
                                          ),
                                        )),
                              bottom: -1,
                              left: 0,
                              right: 0,
                            ),
                          ],
                        );
                      }),
                    ),
                  ];
                },
                body: ViewCategories(storeId: storeId),
              ),
            ),
            _loading ? Center(child: CircularProgressIndicator()) : Container()
          ],
        ),
        bottomNavigationBar: Container(
          height: 60.0,
          child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            color: Constants.secondary_color,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            onPressed: () {
              // Navigator.pushNamed(context, CartScreen.routeName);
              // pass the store info to the cart screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => CartScreen(storeId: storeId),
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  "View basket",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0),
                ),
                SizedBox(
                  width: 8.0,
                ),
                ImageIcon(
                  AssetImage('assets/basket-outline.png'),
                  size: 18.0,
                  color: Colors.white,
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTags(Map<dynamic, dynamic> strings) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i in strings.values)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Text(
                "${i.toString()}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0),
              ),
            ),
        ],
      ),
    );
  }
}
