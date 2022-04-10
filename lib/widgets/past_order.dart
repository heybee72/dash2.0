import 'package:flutter/material.dart';

class PastOrder extends StatelessWidget {
  static const String routeName = "/pastOrder";
  const PastOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(child: ListTile())

          ],
        ),
      ),
    ));
  }
}
