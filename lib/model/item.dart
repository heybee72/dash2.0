import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? itemDescription;
  String? itemID;
  String? itemImage;
  String? itemTitle;
  String? menuID;
  int? price;
  // Timestamp? publishedDate;
  String? status;
  String? storeUID;
  String? storeName;

  Item(
      {this.itemDescription,
      this.itemID,
      this.itemImage,
      this.itemTitle,
      this.menuID,
      this.price,
      // this.publishedDate,
      this.status,
      this.storeUID,
      this.storeName});

  Item.fromJson(Map<String, dynamic> json){
    menuID = json['menuID'];
    itemID = json['itemID'];
    itemTitle = json['itemTitle'];
    itemDescription = json['itemDescription'];
    itemImage = json['itemImage'];
    price = json['price'];
    // publishedDate = json['publishedDate'];
    status = json['status'];
    storeUID = json['storeUID'];
    storeName = json['storeName'];

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data =Map<String, dynamic>();
    data['menuID'] = menuID;
    data['itemID'] = itemID;
    data['itemTitle'] = itemTitle;
    data['itemDescription'] = itemDescription;
    data['itemImage'] = itemImage;
    data['price'] = price;
    // data['publishedDate'] = publishedDate;
    data['status'] = status;
    data['storeUID'] = storeUID;
    data['storeName'] = storeName;
    return data;
  }
}
