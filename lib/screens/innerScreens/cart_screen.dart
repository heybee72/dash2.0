import 'package:dash_user2/assistants/helpers.dart';
import 'package:dash_user2/models&providers/cart.dart';
import 'package:dash_user2/services/global_methods.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:dash_user2/widgets/empty_cart.dart';
import 'package:dash_user2/widgets/full_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkout_screen.dart';


class CartScreen extends StatefulWidget {
  static const routeName = "cartScreen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();

    double service_fee = cartProvider.totalAmount * 0.05;
    double delivery_fee = cartProvider.totalAmount * 0.1;
    double total_amount = cartProvider.totalAmount + service_fee + delivery_fee;




    return cartProvider.cartList.isEmpty
        ? Scaffold(
            body: EmptyCart(),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    globalMethods.showDialogue(
                        context, () => cartProvider.clearCart());
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
                    child: ListView.builder(
                      itemCount: cartProvider.cartList.length,
                      itemBuilder: (ctx, i) {
                        return ChangeNotifierProvider.value(
                          value: cartProvider.cartList.values.toList()[i],
                          child: FullCart(
                              pId: cartProvider.cartList.keys.toList()[i]),
                        );
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Service fee",
                    style: TextStyle(
                      color: Color(0xFF142328),
                      fontSize: 15,
                    ),
                  ),
                  trailing: Text("N ${HelperMethods.converAmt(service_fee)}"),
                ),
                ListTile(
                  title: Text(
                    "Delivery",
                    style: TextStyle(
                      color: Color(0xFF142328),
                      fontSize: 15,
                    ),
                  ),
                  trailing: Text("N${HelperMethods.converAmt(delivery_fee)}"),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "Total",
                    style: TextStyle(
                      color: Color(0xFF142328),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "N${HelperMethods.converAmt(total_amount)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            bottomNavigationBar:
                _bottomCheckoutSection(context, total_amount),
          );
  }

  Container _bottomCheckoutSection(BuildContext context, double totalAmount) {
    return Container(
      height: 60,
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CheckoutScreen.routeName);
        },
        color: Constants.secondary_color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Proceed to Checkout",
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
