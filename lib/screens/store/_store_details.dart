import 'dart:io';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_user_app/controllers/items_controller.dart';
import 'package:dash_user_app/controllers/store_controller.dart';
import 'package:dash_user_app/model/store_model.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/silver_appbar_widget.dart';
import '../../widgets/tab_bar_widget.dart';
import '../bottom_nav_screen.dart';

class StoreDetailScreen extends StatefulWidget {
  static const String routeName = 'store_details';
  final int pageId;
  final String uid;

  const StoreDetailScreen({Key? key, required this.pageId, required this.uid})
      : super(key: key);
  @override
  StoreDetailScreenState createState() => StoreDetailScreenState();
}

class StoreDetailScreenState extends State<StoreDetailScreen> {
  bool _loading = false;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    Get.find<ItemController>().getItemList(widget.uid);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var product = Get.find<StoreController>().storeList[widget.pageId];

    return WillPopScope(
      onWillPop: () async {
        // if (_storeState.cart.items.length > 0) {
        //   bool shouldPop = await showPopUp(context);
        //   if (shouldPop) {
        //     _storeState.clearCart();
        //     return Future.value(shouldPop);
        //   } else {
        //     return Future.value(shouldPop);
        //   }
        // } else {
        return Future.value(true);
        // }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: Colors.white10,
                body: NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return [
                      const SilverWidget(),
                    ];
                  },
                  body: GetBuilder<ItemController>(
                    builder: (itemController) {
                      return Column(
                        children: [
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: _SliverAppBarDelegate(
                              itemController.isLoaded
                                  ? TabBar(
                                      key: UniqueKey(),
                                      indicatorColor: Colors.transparent,
                                      isScrollable: true,
                                      labelColor: Colors.black,
                                      unselectedLabelColor:
                                          Constants.grey_color,
                                      // tabs: itemController.itemList
                                      //     .map((category) => Tab(
                                      //           text: category.catTitle.toString(),
                                      //         ))
                                      //     .toList(),
                                      tabs: const [
                                          Tab(text: "hello"),
                                        ])
                                  : TabBar(
                                      key: UniqueKey(),
                                      tabs: [
                                        Tab(),
                                      ],
                                    ),
                            ),
                          ),
                          const TabBarView(
                            children: [
                              Text("qwerty"),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                  // body: GetBuilder<ItemController>(builder: (itemController) {
                  //   var dummy = itemController.itemList.map((e) {
                  //     return {
                  //       "id": e.id,
                  //       "itemName": e.itemName,
                  //       "itemDescription": e.itemDescription,
                  //       "price": e.price,
                  //       "itemImage": e.itemImage,
                  //       "itemCatId": e.itemCatId,
                  //       "status": e.status,
                  //       "storeId": e.storeId,
                  //       "catTitle": e.catTitle,
                  //       "catImage": e.catImage,
                  //       "catDescription": e.catDescription,
                  //       "storeUid": e.storeUid,
                  //       "storeLat": e.storeLat,
                  //       "storeLng": e.storeLng,
                  //       "storeName": e.storeName
                  //     };
                  //   }).toList();

                  //   print("dummy");
                  //   print(dummy);
                  //   return Container();
                  //   // return GroupedListView<dynamic, String>(

                  //   //   elements: dummy,
                  //   //   groupBy: (element) => element['catTitle'].toString(),
                  //   //   groupSeparatorBuilder: (String groupByValue) => Row(
                  //   //     children: [
                  //   //       Padding(
                  //   //         padding: const EdgeInsets.all(16.0),
                  //   //         child: BigText(
                  //   //           text: groupByValue,
                  //   //           color: AppColors.mainBlackColor,
                  //   //           size: Dimensions.font16 + 2,
                  //   //           fontWeight: FontWeight.bold,
                  //   //         ),
                  //   //       ),
                  //   //     ],
                  //   //   ),
                  //   //   itemBuilder: (context, dynamic element) {
                  //   //     return SizedBox(
                  //   //       width: 100,
                  //   //       child: Text(element['id'].toString()),
                  //   //     );
                  //   //     // return CarouselSlider.builder(
                  //   //     //   itemCount: 10,
                  //   //     //   itemBuilder:
                  //   //     //       (context, int itemIndex, int pageViewIndex) {
                  //   //     //     return Column(
                  //   //     //       children: [
                  //   //     //         Text(element['price']),
                  //   //     //         Image.network(
                  //   //     //             "https://images.pexels.com/photos/13761717/pexels-photo-13761717.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load"),
                  //   //     //       ],
                  //   //     //     );
                  //   //     //   },
                  //   //     //   options: CarouselOptions(
                  //   //     //     autoPlay: true,
                  //   //     //     enlargeCenterPage: true,
                  //   //     //     viewportFraction: 0.9,
                  //   //     //     aspectRatio: 2.0,
                  //   //     //     initialPage: 2,
                  //   //     //     scrollDirection: Axis.horizontal,
                  //   //     //   ),
                  //   //     // );
                  //   //   },
                  //   //   order: GroupedListOrder.DESC,
                  //   // );
                  // }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
