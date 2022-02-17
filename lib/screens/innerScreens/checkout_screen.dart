import 'package:dash_user2/assistants/helpers.dart';
import 'package:dash_user2/models&providers/cart.dart';
import 'package:dash_user2/services/global_methods.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:dash_user2/widgets/empty_cart.dart';
import 'package:dash_user2/widgets/full_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../orders_screen.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = "checkoutScreen";
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();

    double service_fee = cartProvider.totalAmount * 0.05;
    double delivery_fee = cartProvider.totalAmount * 0.1;
    double total_amount = cartProvider.totalAmount + service_fee + delivery_fee;

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
              'KFC',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/location_pin_black.png',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Lagos, Nigeria',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
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
                        title: Text('Add new address',
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
                        title: Text('21, Osapa London',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            textAlign: TextAlign.left),
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
                        title: Text('Add new debit card',
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
                            Text('XXXX XXXX XXXX 1234',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                textAlign: TextAlign.left),
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
      bottomNavigationBar: _bottomCheckoutSection(context, total_amount),
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
              style: TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                // HelperMethods.getCurrency(),
                Text("N ${totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
