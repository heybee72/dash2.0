import 'package:dash_store/model/item.dart';
import 'package:dash_store/screens/items_screen.dart';
import 'package:dash_store/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemDesignWidget extends StatefulWidget {
  Item? model;
  BuildContext? context;

  ItemDesignWidget({this.model, this.context});

  @override
  _ItemDesignWidgetState createState() => _ItemDesignWidgetState();
}

class _ItemDesignWidgetState extends State<ItemDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
                            fontSize: 14, color: Constants.grey_color),
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
              SizedBox(
                width: 12,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "${widget.model!.itemImage!}",
                  width: 70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
