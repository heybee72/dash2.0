class Item {
  late List<ItemData> _items;
  List<ItemData> get items => _items;

  Item({required items}) {
    _items = items;
  }

  Item.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _items = <ItemData>[];
      json['data'].forEach((v) {
        _items.add(new ItemData.fromJson(v));
      });
    }
  }
}

class ItemData {
  String? cat;
  List<Items>? items;

  ItemData({this.cat, this.items});

  ItemData.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat'] = this.cat;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? itemName;
  String? itemDescription;
  String? price;
  String? itemImage;
  String? itemCatId;
  String? status;
  String? storeId;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
      this.itemName,
      this.itemDescription,
      this.price,
      this.itemImage,
      this.itemCatId,
      this.status,
      this.storeId,
      this.createdAt,
      this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    itemDescription = json['itemDescription'];
    price = json['price'];
    itemImage = json['itemImage'];
    itemCatId = json['itemCatId'];
    status = json['status'];
    storeId = json['storeId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'price': price,
      'itemImage': itemImage,
      'itemCatId': itemCatId,
      'status': status,
      'storeId': storeId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
