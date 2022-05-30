import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user_app/assistantMethods/total_amount.dart';
import 'package:dash_user_app/model/itemz.dart';
import 'package:dash_user_app/model/menu.dart';
import 'package:dash_user_app/models&providers/cart.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/widgets/items_design.dart';
import 'package:dash_user_app/widgets/no_item_added.dart';
import 'package:dash_user_app/widgets/progress_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class ItemsScreen extends StatefulWidget {
  final Menu? model;
  final String? storeId;
  ItemsScreen({Key? key, this.model, this.storeId}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.model!.menuTitle}',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("stores")
            .doc(widget.storeId)
            .collection("menus")
            .doc(widget.model!.menuID)
            .collection("items")
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: circularProgress(),
                )
              : snapshot.data!.docs.length == 0
                  ? Center(child: NoItemAdded())
                  : InkWell(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            Itemz model = Itemz.fromJson(
                                snapshot.data!.docs[index].data()!
                                    as Map<String, dynamic>);
                            return SingleChildScrollView(
                              child: ItemDesignWidget(
                                  model: model, context: context),
                            );
                            ;
                          },
                          itemCount: snapshot.data!.docs.length),
                    );
        },
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
                builder: (c) => CartScreen(storeId: widget.storeId),
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
              Consumer<TotalAmount>(builder: (context, amountProvider, c) {
                return RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "₦",
                            style: TextStyle(
                                fontFamily: Platform.isAndroid ? 'Roboto' : '',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0)),
                        TextSpan(
                            text: "${amountProvider.tAmount.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w600))
                      ],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600)),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
