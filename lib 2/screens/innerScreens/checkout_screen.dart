import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user_app/assistants/helpers.dart';
import 'package:dash_user_app/global/global.dart';
import 'package:dash_user_app/models&providers/cart.dart';
import 'package:dash_user_app/screens/auth/get_phone_number_screen.dart';
import 'package:dash_user_app/services/global_methods.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/widgets/display_total_price_values.dart';
import 'package:dash_user_app/widgets/empty_cart.dart';
import 'package:dash_user_app/widgets/full_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../orders_screen.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = "checkoutScreen";
  final double? totalAmount;
  final String? storeUID;
  final String? storeName;
  final String? userAddress;
  final String? storeAddress;
  const CheckoutScreen(
      {Key? key,
      this.totalAmount,
      this.storeUID,
      this.storeName,
      this.userAddress,
      this.storeAddress})
      : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user!.isAnonymous) {
      Navigator.of(context).pushNamed(GetPhoneNumberScreen.routeName);
    } else {
      _getData();
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  late String _uid = '';
  late String _firstname = '';
  late String _lastname = '';
  late String _email = '';
  late String _phone = '';

  void _getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDocs =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    setState(() {
      _firstname = userDocs.get('firstName');
      _lastname = userDocs.get('lastName');
      _email = userDocs.get('email');
      _phone = userDocs.get('phone');
    });
  }

  IconData tIcon = Icons.remove_circle_rounded;
  Color tIconColor = Colors.black;
  bool enable = false;

  IconData newCardtIcon = Icons.radio_button_unchecked;
  Color newCardtIconColor = Colors.black;
  bool newCardEnable = false;

  @override
  Widget build(BuildContext context) {
    // var publicKey = 'pk_test_da0e63fdf062f88a4f71ff06b8f70cea9d52f8eb';
    final paystack = PaystackPlugin();
    bool isLoading = false;
    var _uuid = Uuid();

    Future initializePlugin() async {
      await paystack.initialize(
        publicKey: "pk_test_da0e63fdf062f88a4f71ff06b8f70cea9d52f8eb",
      );
    }

    // getUI
    PaymentCard _getCardUI() {
      return PaymentCard(
          number: '4084084084084081',
          expiryMonth: 02,
          cvc: '408',
          expiryYear: 23);
    }
    // refrernce

    String _getReference() {
      String platform;
      if (Platform.isIOS) {
        platform = 'iOS';
      } else {
        platform = 'Android';
      }

      return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
    }

    Future<void> payWithCard(var price, String email) async {
      initializePlugin().then((_) async {
        Charge charge = Charge()
          ..amount = price * 100
          ..email = email
          ..reference = _getReference()
          ..currency = "NGN"
          ..card = _getCardUI();

        CheckoutResponse response = await paystack.checkout(
          context,
          method: CheckoutMethod.card,
          charge: charge,
          fullscreen: false,
          // logo: Image.asset(
          //   'assets/l2.jpg',
          //   width: 50,
          // )
          logo: FlutterLogo(size: 24),
        );

        print("response $response");
        if (response.status == true) {
          print("success");
        } else {
          print("failed");
        }
      });
    }

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
              '${widget.storeName}',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/location_pin_black.png',
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    "${widget.storeAddress}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    margin: EdgeInsets.all(1.5),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        // leading: Text("My Location"),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("My Location:",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            Text('${widget.userAddress}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.left),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 14.0),
                          child: Image.asset(
                            'assets/check-circle-solid.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    margin: EdgeInsets.all(1.5),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        title: Text('Address Description',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            textAlign: TextAlign.left),
                        onTap: () {},
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    margin: EdgeInsets.all(1.5),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        title: InkWell(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(newCardtIcon,
                                    size: 18, color: newCardtIconColor),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Pay with a new card',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.left),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              newCardEnable = !newCardEnable;
                              if (newCardEnable) {
                                newCardtIcon = Icons.check_circle_rounded;
                                newCardtIconColor = Constants.secondary_color;
                              } else {
                                newCardtIcon = Icons.radio_button_unchecked;
                                newCardtIconColor = Colors.black;
                              }
                              print(newCardEnable);
                            });
                          },
                        ),
                        onTap: () {
                          // payWithCard(
                          //     widget.totalAmount!.toInt(), _email.toString());
                        },
                        trailing: newCardEnable == true
                            ? saveCardOption()
                            : SizedBox(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    margin: EdgeInsets.all(1.5),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            Image.asset(
                              'assets/mastercard-logo.png',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '****  1234',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                            ),
                            InkWell(
                              child: Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {},
                            ),
                          ],
                        ),
                        onTap: () {},
                        trailing: IconButton(
                          icon: Icon(Icons.delete,
                              size: 18, color: Color(0xFFFF5266)),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          _bottomCheckoutSection(context, widget.totalAmount!.toDouble()),
    );
  }

  Wrap saveCardOption() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            "save card",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
        IconButton(
          icon: Icon(tIcon, size: 18, color: tIconColor),
          onPressed: () {
            setState(() {
              enable = !enable;
              if (enable) {
                tIcon = Icons.check_circle_rounded;
                tIconColor = Constants.secondary_color;
              } else {
                tIcon = Icons.remove_circle_rounded;
                tIconColor = Colors.black;
              }
              print(enable);
            });
          },
        ),
      ],
    );
  }

  Container _bottomCheckoutSection(BuildContext context, double totalAmount) {
    return Container(
      height: 60,
      child: RaisedButton(
        onPressed: () {
          // Charge card
          // if successful, move user to active order screen
          // else, show error message
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     // builder: (context) =>  OrdersScreen(index: 1),
          //   ),

          // );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrdersScreen(
                index: 1,
              ),
            ),
          );
        },
        color: Constants.secondary_color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Place Order",
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
  }
}
