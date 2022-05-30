import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user_app/model/menu.dart';
import 'package:dash_user_app/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

import 'info_design.dart';

class ViewCategories extends StatefulWidget {
  const ViewCategories({
    Key? key,
    required this.storeId,
  }) : super(key: key);

  final String storeId;

  @override
  _ViewCategoriesState createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("stores")
          .doc(widget.storeId)
          .collection("menus")
          .orderBy("publishedDate", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(
                child: circularProgress(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Select A Category",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple.shade900),
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.grey.shade200,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Menu model = Menu.fromJson(snapshot.data!.docs[index]
                              .data()! as Map<String, dynamic>);
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: InfoDesignWidget(
                                model: model,
                                storeId: widget.storeId,
                                context: context),
                          );
                        }),
                  ),
                ],
              );
      },
    );
  }
}
