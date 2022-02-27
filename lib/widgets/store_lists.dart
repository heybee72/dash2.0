import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user2/newModels/stores.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:flutter/material.dart';

class StoreLists extends StatefulWidget {
  Sellers? model;
  BuildContext? context;

  StoreLists({Key? key, this.model, this.context}) : super(key: key);

  @override
  _StoreListsState createState() => _StoreListsState();
}

class _StoreListsState extends State<StoreLists> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.of(context).pushNamed(
      //     StoreDetailScreen.routeName,
      //     arguments: storeAttribute.id),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: <Widget>[
              Image.network(
                '${widget.model!.storeImageUrl}',
                fit: BoxFit.cover,
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              Opacity(
                opacity: .6,
                child: Container(
                  color: Constants.primary_color,
                ),
              ),
              Center(
                heightFactor: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    "${widget.model!.storeName}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0),
                  ),
                ),
              ),
              Center(
                heightFactor: 35,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // getTags(widget.model!.storeTags),
                        // _getTags(widget.model!.storeTags!),
                      ]),
                ),
              ),
              Positioned(
                bottom: 5.0,
                right: 10.0,
                child: Text(
                  "30-35 min(s)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//List<Offset> storeTags = <Offset>[];

  Widget getTags(Map<String, String>? storeTags) {
    storeTags!.forEach((key, value) {
      return print("this is the key : $key this is the value :$value");
    });
    // Row(
    //     children: strings
    //         .map((item) => Container(
    //               padding: EdgeInsets.symmetric(horizontal: 14.0),
    //               margin: EdgeInsets.symmetric(horizontal: 5.0),
    //               decoration: BoxDecoration(
    //                   color: Colors.black.withOpacity(0.4),
    //                   borderRadius: BorderRadius.circular(5.0)),
    //               child: Text(
    //                 "${item}",
    //                 style: TextStyle(
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w500,
    //                     fontSize: 12.0),
    //               ),
    //             ))
    //         .toList());

    return Container();
  }
}
