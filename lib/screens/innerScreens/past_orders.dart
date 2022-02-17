
import 'package:dash_user2/widgets/no_past_orders_yet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class PastOrder extends StatefulWidget {
  @override
  _PastOrderState createState() => _PastOrderState();
}

class _PastOrderState extends State<PastOrder> {
  // StoreApi _api;
  // AppState _appState;
  bool _isLoading = true;
  // List<dynamic> data;
  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),

        child: NoPastOrder(),

        // child: _isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : ListView.builder(
        //         // itemCount: data.length,
        //         itemBuilder: (_, index) {
        //           return ListTile(
        //             onTap: () {
        //               // Navigator.of(context)
        //               //     .push(MaterialPageRoute(builder: (context) {
        //               //   return PastOrderView(
        //               //     item: data[index],
        //               //   );
        //               // }));
        //             },
        //             title: Text(''
        //               // DateFormat.yMMMd().format(
        //               //   DateTime.parse(data[index]['created_at']),
        //               // )
        //               ,style: TextStyle(fontSize: 12, color: Color(0XFF888888)),
        //             ),
        //             subtitle: Text(
        //               ''
        //               // "${data[index]['store']['name']}"
        //               ,style: TextStyle(
        //                 fontSize: 16,
        //               ),
        //             ),
        //             trailing: Text(''
        //               // '# ${data[0]['totalItemAmount']}'
        //               ),
        //           );
        //         },
        //       )
       
        );
  }
}
