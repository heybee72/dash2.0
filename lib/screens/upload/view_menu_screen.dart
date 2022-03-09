import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_store/global/global.dart';
import 'package:dash_store/model/menu.dart';
import 'package:dash_store/widgets/info_design.dart';
import 'package:dash_store/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class ViewMenuScreen extends StatefulWidget {
  ViewMenuScreen({Key? key}) : super(key: key);

  @override
  State<ViewMenuScreen> createState() => _ViewMenuScreenState();
}

class _ViewMenuScreenState extends State<ViewMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        title: Row(
          children: [
            SizedBox(width: 35),
            Text('View Menu', style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("stores")
              .doc(sharedPreferences!.getString("uid"))
              .collection("menus")
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: circularProgress(),
                  )
                : InkWell(
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          Menu model = Menu.fromJson(
                          snapshot.data!.docs[index].data()! as Map<String, dynamic>
                        );
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: InfoDesignWidget(model: model, context: context),
                          );
                          ;
                        },
                        itemCount: snapshot.data!.docs.length),
                  );
          }),
    );
  }
}
