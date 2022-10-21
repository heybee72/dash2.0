// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_user_app/model/item_model.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatefulWidget {
  final Map<String, dynamic> item;
  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  // StoreState _storeState;
  // Item _cartItem;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _storeState = Provider.of<StoreState>(context);
    // try {
    //   _cartItem = _storeState.cart.items
    //           .firstWhere((element) => element.id == widget.item.id) ??
    //       null;
    // } catch (e) {
    //   print(e);
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      onTap: () {
        // Navigator.of(context).push(PageTransition(
        //     child: ItemScreen(
        //       item: widget.item,
        //     ),
        //     type: PageTransitionType.downToUp));
      },
      title: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                "_cartItem" != null
                    ? Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        width: 5.0,
                        height: 100.0,
                        color: Constants.secondary_color,
                      )
                    : Container(),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      "_cartItem" != null
                          ? Container(
                              margin: const EdgeInsets.only(right: 12.0),
                              alignment: Alignment.center,
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                  color: Constants.secondary_color,
                                  borderRadius: BorderRadius.circular(2.0)),
                              child: const Text(
                                "1",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ))
                          : Container(),
                      Text(
                        widget.item['itemName'],
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Constants.primary_color,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 4.0),
                    width: size.width * .6,
                    child: Text(
                      widget.item['itemDescription'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13.0, color: Constants.grey_color),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: "₦ ",
                              style: TextStyle(
                                  fontFamily:
                                      Platform.isAndroid ? 'Roboto' : '')),
                          TextSpan(
                            text: widget.item["price"],
                          ),
                        ],
                        style: const TextStyle(
                            fontSize: 13.0, color: Constants.primary_color)),
                  ),
                ]),
                Expanded(child: Container()),
                ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.item["itemImage"],
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
          const Divider(
            height: 8,
            color: Color(
              0XFFF4F4F4,
            ),
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}
