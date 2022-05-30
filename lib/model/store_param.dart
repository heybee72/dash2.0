class StoreParamModel {
  int? id;
  String? address;
  double? latitude;
  double? longitude;
  String? category;

  StoreParamModel({
    this.id,
    this.address,
    this.latitude,
    this.longitude,
    this.category,
  });

  StoreParamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    category = json['category'];
  }
}
