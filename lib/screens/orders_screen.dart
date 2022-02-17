// import 'package:flutter/material.dart';

// class OrdersScreen extends StatelessWidget {
//   static const routeName = '/orders-screen';
//   const OrdersScreen({Key? key, int? index}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Orders'),
//       ),
//       body: Center(
//         child: Text('Orders'),
//       ),

//     );
//   }
// }

import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'innerScreens/active_order.dart';
import 'innerScreens/past_orders.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';
  final int index;
  const OrdersScreen({Key? key, required this.index}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with AutomaticKeepAliveClientMixin {
  int index = 0;
  @override
  void initState() {
    super.initState();
    // index = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("index is: ${widget.index}");
    return DefaultTabController(
      initialIndex: widget.index,
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          indicatorWeight: 2.0,
          indicatorColor: Colors.green,
          onTap: (ind) {
            setState(() {
              index = ind;
            });
          },
          tabs: [
            Container(
              margin: EdgeInsets.only(top: 25),
              alignment: Alignment.center,
              color: Colors.white24,
              height: 82.0,
              child: Text(
                "Past",
                style: TextStyle(
                    color: index == 0
                        ? Constants.primary_color
                        : Constants.grey_color,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.white24,
              height: 82.0,
              child: Text(
                "Active",
                style: TextStyle(
                    color: index == 1
                        ? Constants.primary_color
                        : Constants.grey_color,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            // Icon(Icons.directions_car),
            PastOrder(),
            ActiveOrder(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
