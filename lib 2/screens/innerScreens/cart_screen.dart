import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user_app/assistantMethods/assistant_methods.dart';
import 'package:dash_user_app/assistantMethods/cart_item_counter.dart';
import 'package:dash_user_app/assistantMethods/total_amount.dart';
import 'package:dash_user_app/assistants/helpers.dart';
import 'package:dash_user_app/model/itemz.dart';
import 'package:dash_user_app/models&providers/cart.dart';
import 'package:dash_user_app/services/global_methods.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/widgets/display_total_price_values.dart';
import 'package:dash_user_app/widgets/empty_cart.dart';
import 'package:dash_user_app/widgets/full_cart.dart';
import 'package:dash_user_app/widgets/progress_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "cartScreen";
  final String? storeId;
  final Itemz? model;
  // final

  const CartScreen({Key? key, this.storeId, this.model}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separateItemQtysList;
  num totalAmount = 0.00;
  num service_fee = 0.00;
  num delivery_fee = 0.00;
  num total_amount = 0.00;
  double final_amount = 0.00;

  FirebaseAuth _auth = FirebaseAuth.instance;
  late String _uid = '';
  late double userLng = 0.00;
  late double userLat = 0.00;
  late String userAddress = "";
  late double storeLng = 0.00;
  late double storeLat = 0.00;
  late String storeName = "";
  late String storeAddress = "";

  void _getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDocs =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    setState(() {
      userLng = userDocs.get('lng');
      userLat = userDocs.get('lat');
      userAddress = userDocs.get('location');
    });
  }

  getStoreDetails() async {
    final DocumentSnapshot storeDocs = await FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeId)
        .get();

    setState(() {
      storeLng = storeDocs.get('lng');
      storeLat = storeDocs.get('lat');
      storeName = storeDocs.get('storeName');
      storeAddress = storeDocs.get('storeLocation');
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0.00);
    separateItemQtysList = separateItemQtys();
    _getData();
    getStoreDetails();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartcounter = Provider.of<CartItemCounter>(context);
    GlobalMethods globalMethods = GlobalMethods();

    // double  = cartProvider.totalAmount * 0.1;

    return cartcounter.cartListItemcounter == 0
        ? Scaffold(
            body: EmptyCart(),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    clearCartNow(context);
                  },
                ),
              ],
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
                    '${storeName}',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('items')
                        .where("itemID", whereIn: separateItemIds())
                        .orderBy("publishedDate", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? Center(
                              child: circularProgress(),
                            )
                          : snapshot.data!.docs.length == 0
                              ?
                              // display empyty cart screen
                              EmptyCart()
                              :
                              // start building cart data
                              ListView.builder(
                                  itemCount: snapshot.hasData
                                      ? snapshot.data!.docs.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    Itemz model = Itemz.fromJson(
                                      snapshot.data!.docs[index].data()!
                                          as Map<String, dynamic>,
                                    );
                                    if (index == 0) {
                                      totalAmount = 0.00;
                                      totalAmount = totalAmount +
                                          (double.parse(
                                                  model.price.toString()) *
                                              separateItemQtysList![index]);
                                    } else {
                                      totalAmount = totalAmount +
                                          (double.parse(
                                                  model.price.toString()) *
                                              separateItemQtysList![index]);
                                    }

                                    if (snapshot.data!.docs.length - 1 ==
                                        index) {
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) {
                                        Provider.of<TotalAmount>(context,
                                                listen: false)
                                            .displayTotalAmount(
                                                totalAmount.toDouble());
                                      });
                                    }

                                    return SingleChildScrollView(
                                      child: FullCart(
                                        model: model,
                                        context: context,
                                        quantity: separateItemQtysList![index],
                                      ),
                                    );
                                  });
                    },
                  ),
                ),
                cartcounter.cartListItemcounter == 0
                    ? Container()
                    : Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Service fee",
                              style: TextStyle(
                                color: Color(0xFF142328),
                                fontSize: 15,
                              ),
                            ),
                            trailing: Consumer<TotalAmount>(
                                builder: (context, amountProvider, c) {
                              double dTotalAmt = amountProvider.tAmount;

                              service_fee = dTotalAmt * 0.05;
                              return DisplayValue(
                                amt: service_fee.toStringAsFixed(2),
                                color: Colors.grey[800],
                              );
                            }),
                          ),
                          ListTile(
                            title: Text(
                              "Delivery",
                              style: TextStyle(
                                color: Color(0xFF142328),
                                fontSize: 15,
                              ),
                            ),
                            trailing: Consumer<TotalAmount>(
                                builder: (context, amountProvider, c) {
                              double dTotalAmt = amountProvider.tAmount;
                              delivery_fee = dTotalAmt * 0.1;

                              var datt = Geolocator.distanceBetween(
                                  storeLat, storeLng, userLat, userLng);
                              datt = datt / 1000;
                              delivery_fee = delivery_fee * datt;

                              return DisplayValue(
                                  amt: delivery_fee.toStringAsFixed(2),
                                  color: Colors.grey[800]);
                            }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text(
                              "Item(s) Total",
                              style: TextStyle(
                                color: Color(0xFF142328),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Consumer<TotalAmount>(
                                builder: (context, amountProvider, c) {
                              total_amount = amountProvider.tAmount;

                              return DisplayValue(
                                amt: total_amount.toStringAsFixed(2),
                                color: Colors.black,
                                fWeight: FontWeight.w900,
                              );
                            }),

                            // Text(
                            //   "N${HelperMethods.converAmt(total_amount)}",
                            //   style: TextStyle(fontWeight: FontWeight.bold),
                            // ),
                          ),
                        ],
                      ),
              ],
            ),
            bottomNavigationBar: _bottomCheckoutSection(context),
          );
  }

  Widget _bottomCheckoutSection(BuildContext context) {
    return Consumer<TotalAmount>(builder: (context, amountProvider, c) {
      total_amount = amountProvider.tAmount;
      service_fee = total_amount * 0.05;
      delivery_fee = total_amount * 0.1;
      var datt =
          Geolocator.distanceBetween(storeLat, storeLng, userLat, userLng);
      datt = datt / 1000;
      delivery_fee = delivery_fee * datt;

      totalAmount = total_amount + service_fee + delivery_fee;
      return Container(
        height: 60,
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => CheckoutScreen(
                    totalAmount: totalAmount.toDouble(),
                    storeUID: widget.storeId,
                    storeName: storeName,
                    userAddress: userAddress,
                    storeAddress: storeAddress),
              ),
            );
            // Navigator.of(context).pushNamed(CheckoutScreen.routeName);
          },
          color: Constants.secondary_color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Proceed to Checkout",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              DisplayValue(
                amt: totalAmount.toStringAsFixed(2),
                color: Colors.white,
                fWeight: FontWeight.w900,
              ),
            ],
          ),
        ),
      );
    });
  }
}
