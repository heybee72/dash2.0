// import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String? menuID;
  String? menuTitle;
  String? menuInfo;
  String? menuImage;
  String? status;
  // Timestamp? publishedDate;

  Menu({
    this.menuID,
    this.menuTitle,
    this.menuInfo,
    this.menuImage,
    this.status,
    // this.publishedDate,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    menuID = json['menuID'];
    menuTitle = json['menuTitle'];
    menuInfo = json['menuInfo'];
    menuImage = json['menuImage'];
    status = json['status'];
    // publishedDate = json['publishedDate'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['menuID'] = menuID;
    data['menuTitle'] = menuTitle;
    data['menuInfo'] = menuInfo;
    data['menuImage'] = menuImage;
    data['status'] = status;
    // data['publishedDate'] = publishedDate;
    
    return data;
  }
}
