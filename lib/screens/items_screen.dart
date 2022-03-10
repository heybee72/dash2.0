import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_store/global/global.dart';
import 'package:dash_store/model/item.dart';
import 'package:dash_store/model/menu.dart';
import 'package:dash_store/utils/constants.dart';
import 'package:dash_store/widgets/info_design.dart';
import 'package:dash_store/widgets/items_design.dart';
import 'package:dash_store/widgets/no_item_added.dart';
import 'package:dash_store/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

import 'upload/items_upload_screen.dart';

class ItemsScreen extends StatefulWidget {
  final Menu? model;
  ItemsScreen({Key? key, this.model}) : super(key: key);

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Constants.secondary_color,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ItemsUploadScreen(model: widget.model)),
                );
              },
              child: Row(
                children: [
                  Text("add new"),
                  Icon(Icons.add),
                ],
              ),
            ),
          ),

          // SizedBox(
          //   width: 50,
          // ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("stores")
              .doc(sharedPreferences!.getString("uid"))
              .collection("menus")
              .doc(widget.model!.menuID)
              .collection("items").orderBy("publishedDate", descending: true)
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
                              Item model = Item.fromJson(
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
          }),
    );
  }
}
