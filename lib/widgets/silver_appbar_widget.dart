import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/bottom_nav_screen.dart';
import '../utils/dimensions.dart';
import 'app_icon.dart';
import 'big_text.dart';

class SilverWidget extends StatelessWidget {
  const SilverWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
            const Flexible(
              flex: 1,
              child: Text("product.storeName", textAlign: TextAlign.center),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
        background: Image.network(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(top: 10, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20),
              topRight: Radius.circular(Dimensions.radius20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, bottom: 8, top: 8.0, right: 16.0),
            child: Row(
              children: [
                BigText(
                  text: "Store information",
                  size: Dimensions.font16,
                ),
                const Spacer(),
                const Icon(
                  Icons.info_outline,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTab extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const TabBar(
      tabs: [
        Tab(
          // text: 'Grid',
          child: Text(
            "Grid",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          height: 100,
        ),
        Tab(
          text: 'List',
        ),
        Tab(
          text: 'Manush',
        ),
        Tab(
          text: 'Shoytan',
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double maxExtent = 110;
  @override
  double minExtent = 20;
}
