class Sellers {
  String? storeUID;
  String? storeName;
  String? storeLocation;
  String? storeImageUrl;
  String? storePhone;
  String? storeEmail;
  String? status;
  double? lng;
  double? lat;
  Map<String, String>? storeTags;

  Sellers(
      {this.storeName,
      this.storeLocation,
      this.storeImageUrl,
      this.storePhone,
      this.storeEmail,
      this.status,
      this.lng,
      this.lat,
      this.storeTags,
      this.storeUID});

  Sellers.fromJson(Map<String, dynamic> json) {
    storeUID = json["storeUID"];
    storeName = json["storeName"];
    storeLocation = json["storeLocation"];
    storeImageUrl = json["storeImageUrl"];
    storePhone = json["storePhone"];
    storeEmail = json["storeEmail"];
    status = json["status"];
    lng = json["lng"];
    lat = json["lat"];
    // storeTags = json["storeTags"].toM;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["storeUID"] = this.storeUID;
    data["storeName"] = this.storeName;
    data["storeLocation"] = this.storeLocation;
    data["storeImageUrl"] = this.storeImageUrl;
    data["storePhone"] = this.storePhone;
    data["storeEmail"] = this.storeEmail;
    data["status"] = this.status;
    data["lng"] = this.lng;
    data["lat"] = this.lat;
    // data["storeTags"] = this.storeTags;

    return data;
  }
}
