import 'package:dash_user_app/assistantMethods/assistant_methods.dart';
import 'package:dash_user_app/model/itemz.dart';
import 'package:dash_user_app/screens/store/item_details_screen.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemDesignWidget extends StatefulWidget {
  Itemz? model;
  BuildContext? context;

  ItemDesignWidget({this.model, this.context});

  @override
  _ItemDesignWidgetState createState() => _ItemDesignWidgetState();
}

class _ItemDesignWidgetState extends State<ItemDesignWidget> {
  @override
  void initState() {
    super.initState();
    
  }

  List<String> separateItemIdsList = separateItemIds();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ItemDetailsScreen.routeName, arguments: {
            'itemId': widget.model!.itemID!.toString(),
            'title': widget.model!.itemTitle!,
            'price': widget.model!.price!.toInt(),
            'description': widget.model!.itemDescription!,
            'image': widget.model!.itemImage!,
            // 'storeId': widget.model!.storeUID!.toString(),
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .95,
          child: Card(
            elevation: 0,
            child: Row(
              children: [
                separateItemIdsList.contains(widget.model!.itemID!.toString())
                    ? Row(
                        children: [
                          Container(
                            width: 5,
                            height: MediaQuery.of(context).size.height * .13,
                            color: Constants.secondary_color,
                          ),
                        ],
                      )
                    : Container(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${widget.model!.itemTitle!}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${widget.model!.itemDescription!}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Constants.grey_color),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "N ${widget.model!.price!}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  "${widget.model!.itemImage!}",
                                  width: 90,
                                  height: 70,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
