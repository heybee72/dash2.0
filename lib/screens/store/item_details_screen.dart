import 'dart:io';

import 'package:dash_user_app/controllers/cart_controller.dart';
import 'package:dash_user_app/controllers/items_controller.dart';
import 'package:dash_user_app/model/item_model.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetailsScreen extends StatefulWidget {
  final int pageId;
  final int itemListIndex;
  ItemDetailsScreen(
      {Key? key, required this.pageId, required this.itemListIndex})
      : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // var items = Get.find<ItemController>().itemList[widget.pageId]
    //     [widget.itemListIndex];

    // print(items);
    var itemList = Get.find<ItemController>().itemList[widget.itemListIndex];

    var item = itemList.toJson();

    var items = item['items'][widget.pageId];
    // print(items);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.grey,
            ),
            bottom: PreferredSize(
              child: Container(),
              preferredSize: const Size(0, 20),
            ),
            pinned: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: Stack(
              children: [
                Positioned(
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Image.network(
                            items['itemImage'].toString(),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.6,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: Row(
                      children: [
                        Text(
                          items['itemName'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Constants.primary_color),
                        ),
                        const SizedBox(width: 8.0),
                        const Text("-"),
                        const SizedBox(width: 8.0),
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Image.asset("assets/naira.png", width: 18),
                            ),
                            Text(
                              "${items['price'].toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Constants.primary_color),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    items['itemDescription'].toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Constants.grey_color,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                // Container(
                //   margin:
                //       EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                //   decoration: BoxDecoration(
                //       color: Constants.background_color_2,
                //       borderRadius: BorderRadius.circular(5.0)),
                //   child: TextField(
                //     controller: _textEditingController,
                //     maxLines: 3,
                //     minLines: 3,
                //     decoration: InputDecoration(
                //         hintText: "Special instructions",
                //         hintStyle: TextStyle(
                //             color: Constants.grey_color,
                //             fontSize: 15.0,
                //             fontWeight: FontWeight.w500),
                //         border:
                //             OutlineInputBorder(borderSide: BorderSide.none)),
                //   ),
                // ),
                const SizedBox(
                  height: 32.0,
                ),
                GetBuilder<ItemController>(builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(180),
                        onTap: () {
                          controller.setQuantity(false); // increment
                        },
                        child: Container(
                          width: 52.0,
                          height: 52.0,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Constants.background_color_2,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 0.3)),
                          child: const Icon(Icons.remove, color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 39.0),
                        width: 32.0,
                        child: Text(
                          controller.inCartItems.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Constants.primary_color),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(180),
                        onTap: () {
                          controller.setQuantity(true); // increment
                        },
                        child: Container(
                          width: 52.0,
                          height: 52.0,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.black45, width: 0.3)),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 48.0,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<ItemController>(builder: (controller) {
        return Container(
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Constants.secondary_color,
            ),
            // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            // color: Constants.secondary_color,
            // padding: const EdgeInsets.symmetric(horizontal: 20.0),
            onPressed: () {
              print(items);
              // controller.addItem(items);
            },
            child: Row(
              children: [
                const Text(
                  "Add to basket",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const ImageIcon(
                  AssetImage('assets/basket-outline.png'),
                  size: 15.0,
                  color: Colors.white,
                ),
                Expanded(child: Container()),
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "₦",
                            style: TextStyle(
                                fontFamily: Platform.isAndroid ? 'Roboto' : '',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0)),
                        TextSpan(
                            text:
                                "${(int.parse(items['price']) * controller.inCartItems).toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w600))
                      ],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
