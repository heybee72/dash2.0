import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_user_app/controllers/items_controller.dart';
import 'package:dash_user_app/controllers/store_controller.dart';
import 'package:dash_user_app/model/item_model.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/item_widget.dart';

class StoreDetailScreen extends StatefulWidget {
  static const String routeName = 'store_details';
  final int pageId;
  final String uid;

  const StoreDetailScreen({Key? key, required this.pageId, required this.uid})
      : super(key: key);

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Get.find<ItemController>().getItemList(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var store = Get.find<StoreController>().storeList[widget.pageId];
    Get.find<ItemController>().getItemList(widget.uid);


    return GetBuilder<ItemController>(builder: (itemController) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            DefaultTabController(
              length: itemController.catLength,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
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
                                      child: CachedNetworkImage(
                                        width: size.width,
                                        height: 300.0,
                                        imageUrl: store.storeImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        store.storeName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                    // Container(
                                    //     margin:
                                    //         const EdgeInsets.only(top: 42.0),
                                    //     alignment: Alignment.center,
                                    //     child: Center(
                                    //       child: Wrap(
                                    //         children: storeTags
                                    //             .map((tag) => Container(
                                    //                   padding: const EdgeInsets
                                    //                           .symmetric(
                                    //                       horizontal: 14.0),
                                    //                   margin: const EdgeInsets
                                    //                           .symmetric(
                                    //                       horizontal: 5.0),
                                    //                   decoration: BoxDecoration(
                                    //                       color: Colors.black
                                    //                           .withOpacity(0.4),
                                    //                       borderRadius:
                                    //                           BorderRadius
                                    //                               .circular(
                                    //                                   5.0)),
                                    //                   child: Text(
                                    //                     tag,
                                    //                     style: const TextStyle(
                                    //                         color: Colors.white,
                                    //                         fontSize: 10.0),
                                    //                   ),
                                    //                 ))
                                    //             .toList()
                                    //             .cast<Widget>(),
                                    //       ),
                                    //     )),
                                    Positioned(
                                      bottom: size.height * .1,
                                      right: 10.0,
                                      child: const Text(
                                        "_store.deliveryTime",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // top: 0,
                                      // left: 0,
                                    ),
                                  ],
                                ),
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0),
                            Positioned(
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 21.0),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: height > 80
                                        ? const BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          )
                                        : BorderRadius.zero,
                                  ),
                                  child: height > 80
                                      ? InkWell(
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) {
                                            //   return StoreInfo();
                                            // }));
                                          },
                                          child: Row(
                                            children: [
                                              const Text(
                                                "Restaurant info",
                                                style: TextStyle(
                                                    color:
                                                        Constants.primary_color,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Expanded(child: Container()),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color(0XFFC4C4C4),
                                                size: 14.0,
                                              )
                                            ],
                                          ),
                                        )
                                      : Stack(children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.arrow_back_ios),
                                              color: Constants.primary_color,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: size.width * .5,
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "_store.name",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color:
                                                        Constants.primary_color,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          )
                                        ])),
                              bottom: -1,
                              left: 0,
                              right: 0,
                            ),
                          ],
                        );
                      }),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          key: UniqueKey(),
                          indicatorColor: Colors.transparent,
                          isScrollable: true,
                          labelColor: Colors.black,
                          unselectedLabelColor: Constants.grey_color,
                          tabs: itemController.cat
                              .map((category) => Tab(
                                    text: category,
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: itemController.itemList
                      .map((category) => TabBarChild(
                            categoryMap: category,
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      );
    });
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

class TabBarChild extends StatefulWidget {
  final dynamic categoryMap;

  const TabBarChild({Key? key, @required this.categoryMap}) : super(key: key);

  @override
  _TabBarChildState createState() => _TabBarChildState();
}

class _TabBarChildState extends State<TabBarChild> {
  // StoreCategory _category;
  @override
  void initState() {
    super.initState();
    // _category = StoreCategory.fromJson(widget.categoryMap);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
          itemCount: widget.categoryMap.length,
          itemBuilder: (context, index) {
            // if(item.isSellable){
            //   return ItemWidget(item: item);
            // } else {
            //   return Container();
            // }
            return ItemWidget(item: widget.categoryMap[index]);
          }),
    );
  }
}
