import 'package:dash_user2/models&providers/cart.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullCart extends StatefulWidget {
  final String pId;

  FullCart({
    Key? key,
    required this.pId,
  }) : super(key: key);

  @override
  _FullCartState createState() => _FullCartState();
}

class _FullCartState extends State<FullCart> {
  @override
  Widget build(BuildContext context) {
    final cartAttribute = Provider.of<Cart>(context);

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Card(
          color: Colors.white,
          elevation: 0.1,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 0),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListTile(
              title: Row(
                children: [
                  
                  Text('${cartAttribute.quantity}X'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${cartAttribute.title}",
                    style: TextStyle(
                      color: Color(0xFF142328),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              trailing: Text("N ${cartAttribute.price}"),
            ),
          ),
        ),
      ],
    );
  }
}
