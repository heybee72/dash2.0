import 'package:dash_user2/models&providers/cart.dart';
import 'package:dash_user2/services/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "cartScreen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();
    return Scaffold(
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
          Card(
            color: Color(0xFFF4F4F4),
            elevation: 0.1,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 0),
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListTile(
                leading: Text("2 X"),
                title: Text(
                  "5-in-1 Meal (Zinger Wing)",
                  style: TextStyle(
                    color: Color(0xF7777777),
                    fontSize: 13,
                  ),
                ),
                trailing:Text("N2,500"),

              ),
            ),
          )
        ],
      ),
    );
  }
}