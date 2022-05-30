class Store {
  late List<StoreModel> _stores;
  List<StoreModel> get stores => _stores;

  Store({required stores}) {
    _stores = stores;
  }

  Store.fromJson(Map<String, dynamic> json) {
    if (json['store'] != null) {
      _stores = <StoreModel>[];
      json['store'].forEach((v) {
        _stores.add(new StoreModel.fromJson(v));
      });
    }
  }
}

class StoreModel {
  String? id;
  String? uid;
  String? storeName;
  String? storeEmail;
  String? password;
  String? storePhone;
  String? lat;
  String? lng;
  String? storeLocation;
  String? storeImage;
  String? status;
  String? storeTags;
  Null? earnings;
  String? createdAt;
  String? updatedAt;
  String? category;
  String? distance;

  StoreModel(
      {this.id,
      this.uid,
      this.storeName,
      this.storeEmail,
      this.password,
      this.storePhone,
      this.lat,
      this.lng,
      this.storeLocation,
      this.storeImage,
      this.status,
      this.storeTags,
      this.earnings,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.distance});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    storeName = json['storeName'];
    storeEmail = json['storeEmail'];
    password = json['password'];
    storePhone = json['storePhone'];
    lat = json['lat'];
    lng = json['lng'];
    storeLocation = json['storeLocation'];
    storeImage = json['storeImage'];
    status = json['status'];
    storeTags = json['storeTags'];
    earnings = json['earnings'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'uid': this.uid,
      'storeName': this.storeName,
      'storeEmail': this.storeEmail,
      'password': this.password,
      'storePhone': this.storePhone,
      'lat': this.lat,
      'lng': this.lng,
      'storeLocation': this.storeLocation,
      'storeImage': this.storeImage,
      'status': this.status,
      'storeTags': this.storeTags,
      'earnings': this.earnings,
      'created_at': this.createdAt,
      'updated_at': this.updatedAt,
      'category': this.category,
      'distance': this.distance,
    };
  }
}
