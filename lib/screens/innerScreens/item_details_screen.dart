import 'dart:io';

import 'package:dash_user_app/assistantMethods/assistant_methods.dart';
import 'package:dash_user_app/assistantMethods/total_amount.dart';
import 'package:dash_user_app/global/global.dart';
import 'package:dash_user_app/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemDetailsScreen extends StatefulWidget {
  ItemDetailsScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = 'item_details_screen';

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  Size? size;
  int _quantity = 1;

  bool _loading = false;

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    // final String storeId = arg['storeId'];
    final String itemId = arg['itemId'];
    final String title = arg['title'];
    final price = arg['price'].toString();
    final String description = arg['description'];
    final String image = arg['image'];

    double subTotal = double.parse(price) * _quantity;

    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.grey,
              ),
              bottom: PreferredSize(
                child: Container(),
                preferredSize: Size(0, 20),
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
                              "${image}",
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0),
                  Positioned(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                    ),
                    bottom: -1,
                    left: 0,
                    right: 0,
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      children: [
                        Text(
                          "${title} ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Constants.primary_color),
                        ),
                        SizedBox(width: 8.0),
                        Text("-"),
                        SizedBox(width: 8.0),
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Image.asset("assets/naira.png", width: 18),
                            ),
                            Text(
                              "${price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Constants.primary_color),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "${description}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Constants.grey_color,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    decoration: BoxDecoration(
                        color: Constants.background_color_2,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: TextField(
                      controller: _textEditingController,
                      maxLines: 3,
                      minLines: 3,
                      decoration: InputDecoration(
                          hintText: "Special instructions",
                          hintStyle: TextStyle(
                              color: Constants.grey_color,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(180),
                        onTap: _quantity == 1
                            ? null
                            : () {
                                setState(() {
                                  _quantity--;
                                });
                              },
                        child: Container(
                          width: 52.0,
                          height: 52.0,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: _quantity > 1
                                  ? Colors.white
                                  : Constants.background_color_2,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: _quantity > 1
                                      ? Colors.black45
                                      : Colors.white,
                                  width: 0.3)),
                          child: Icon(
                            Icons.remove,
                            color: _quantity > 1
                                ? Colors.black
                                : Color(0XFFC4C4C4),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 39.0),
                          width: 32.0,
                          child: Text(
                            _quantity.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Constants.primary_color),
                          )),
                      InkWell(
                        borderRadius: BorderRadius.circular(180),
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        child: Container(
                          width: 52.0,
                          height: 52.0,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.black45, width: 0.3)),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          color: Constants.secondary_color,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          onPressed: () async {
            //check if item already exixst in cart
            List<String> separateItemIdsList = separateItemIds();
            separateItemIdsList.contains(itemId)
                ?
                // replace this with updating the quantity
                // Container()
                // updateItemToCart(itemId, context, _quantity)
                Fluttertoast.showToast(msg: "Item already in cart")
                :
                // add to cart
                addItemToCart(itemId, context, _quantity);

            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: _loading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : Row(
                  children: [
                    Text(
                      "Add to basket",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    ImageIcon(
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
                                    fontFamily:
                                        Platform.isAndroid ? 'Roboto' : '',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0)),
                            TextSpan(
                                text: "${(subTotal).toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600))
                          ],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
