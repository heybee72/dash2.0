import 'package:dash_user_app/controllers/items_controller.dart';
import 'package:dash_user_app/controllers/store_controller.dart';
import 'package:dash_user_app/model/item_model.dart';
import 'package:dash_user_app/routes/route_helper.dart';
import 'package:dash_user_app/utils/colors.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/dimensions.dart';
import 'package:dash_user_app/widgets/app_icon.dart';
import 'package:dash_user_app/widgets/big_text.dart';
import 'package:dash_user_app/widgets/general_small_text.dart';
import 'package:dash_user_app/widgets/loader_widget.dart';
import 'package:dash_user_app/widgets/no_delivery.dart';
import 'package:dash_user_app/widgets/no_item_added.dart';
import 'package:dash_user_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottom_nav_screen.dart';

class StoreDetailScreen extends StatefulWidget {
  static const String routeName = 'store_details';
  final int pageId;
  final String uid;
  StoreDetailScreen({
    Key? key,
    required this.pageId,
    required this.uid,
  }) : super(key: key);

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  var _curPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    Get.find<ItemController>().getItemList(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    var product = Get.find<StoreController>().storeList[widget.pageId];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            backgroundColor: Colors.white,
            expandedHeight: 250,
            title: GestureDetector(
              onTap: () {
                Get.to(() => BottomNavScreen());
              },
              child: AppIcon(icon: Icons.arrow_back_ios),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(product.storeName, textAlign: TextAlign.center),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              background: Image.network(
                product.storeImage,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 10, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, bottom: 8, top: 8.0, right: 16.0),
                  child: Row(
                    children: [
                      BigText(
                        text: "Store information",
                        size: Dimensions.font16,
                      ),
                      Spacer(),
                      Icon(
                        Icons.info_outline,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<ItemController>(
                    builder: (items) {
                      return items.isLoaded == false
                          ? LoaderWidget()
                          : items.itemFound
                              ? _items(items)
                              : NoItemAdded();
                    },
                  ),
                ),
                SizedBox(height: Dimensions.height20),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar - 40,
        padding: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
        ),
        decoration: BoxDecoration(
          color: Constants.secondary_color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // controller.addItem(product);
              },
              child: Container(
                child: Row(
                  children: [
                    BigText(text: "View basket", color: Colors.white),
                    SizedBox(width: Dimensions.width10),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Text("120"),
            ),
          ],
        ),
      ),
    );
  }

  ListView _items(ItemController items) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.itemList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 8, bottom: 16),
              child: BigText(
                text: items.itemList[index].cat,
                size: Dimensions.font26 - 5,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: Container(
                height: Dimensions.pageView,
                child: PageView.builder(
                  itemCount: items.itemList[index].items.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, index,
                        items.itemList[index].items[position]);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPageItem(int index, int itemListIndex, Items item) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getItemDetails(index, itemListIndex));
          },
          child: Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? Colors.pink : Colors.blue,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  item.itemImage.toString(),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 0),
                ),
              ],
            ),
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                  top: Dimensions.height15, right: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: item.itemName.toString(),
                        size: 18,
                      ),
                      BigText(
                        text: "NGN" + item.price.toString(),
                        size: 18,
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  GeneralSmallText(text: item.itemDescription.toString()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
