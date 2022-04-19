class StoreModel {
  String uid;
  String storeName;
  String storeEmail;
  String storePhone;
  double lat;
  double lng;
  String storeImage;
  String storeLocation;
  String status;
  String storeTags;
  String category;
  double distance;

  StoreModel(
      {required this.uid,
      required this.storeName,
      required this.storeEmail,
      required this.storePhone,
      required this.lat,
      required this.lng,
      required this.storeImage,
      required this.storeLocation,
      required this.status,
      required this.storeTags,
      required this.category,
      required this.distance});

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['firstName'] = this.firstName;

  //   return data;
  // }

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      uid: json['uid'],
      storeName: json['storeName'],
      storeEmail: json['storeEmail'],
      storePhone: json['storePhone'],
      lat: json['lat'],
      lng: json['lng'],
      storeImage: json['storeImage'],
      storeLocation: json['storeLocation'],
      status: json['status'],
      storeTags: json['storeTags'],
      category: json['category'],
      distance: json['distance'],
    );
  }
}
