// class Item {
//   int? _totalSize;
//   late List<ItemModel> _items;
//   List<ItemModel> get items => _items;
//   int? get totalSize => _totalSize;

//   Item({required totalSize, required items}) {
//     _totalSize = totalSize;
//     _items = items;
//   }

//   Item.fromJson(Map<String, dynamic> json) {
//     _totalSize = json['total_size'];
//     if (json['item'] != null) {
//       _items = <ItemModel>[];
//       json['item'].forEach((v) {
//         _items.add(ItemModel.fromJson(v));
//       });
//     }
//   }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['total_size'] = totalSize;
//   //   if (item != null) {
//   //     data['item'] = item!.map((v) => v.toJson()).toList();
//   //   }
//   //   return data;
//   // }
// }

// class ItemModel {
//   String? id;
//   String? itemName;
//   String? itemDescription;
//   String? price;
//   String? itemImage;
//   String? itemCatId;
//   String? status;
//   String? storeId;
//   String? createdAt;
//   String? updatedAt;
//   String? catTitle;
//   String? catImage;
//   String? catDescription;
//   String? storeUid;
//   String? storeLat;
//   String? storeLng;
//   String? storeName;

//   ItemModel(
//       {this.id,
//       this.itemName,
//       this.itemDescription,
//       this.price,
//       this.itemImage,
//       this.itemCatId,
//       this.status,
//       this.storeId,
//       this.createdAt,
//       this.updatedAt,
//       this.catTitle,
//       this.catImage,
//       this.catDescription,
//       this.storeUid,
//       this.storeLat,
//       this.storeLng,
//       this.storeName});

//   ItemModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     itemName = json['itemName'];
//     itemDescription = json['itemDescription'];
//     price = json['price'];
//     itemImage = json['itemImage'];
//     itemCatId = json['itemCatId'];
//     status = json['status'];
//     storeId = json['storeId'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     catTitle = json['cat_title'];
//     catImage = json['cat_image'];
//     catDescription = json['cat_description'];
//     storeId = json['store_id'];
//     storeUid = json['store_uid'];
//     storeLat = json['store_lat'];
//     storeLng = json['store_lng'];
//     storeName = json['storeName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['itemName'] = itemName;
//     data['itemDescription'] = itemDescription;
//     data['price'] = price;
//     data['itemImage'] = itemImage;
//     data['itemCatId'] = itemCatId;
//     data['status'] = status;
//     data['storeId'] = storeId;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['cat_title'] = catTitle;
//     data['cat_image'] = catImage;
//     data['cat_description'] = catDescription;
//     data['store_id'] = storeId;
//     data['store_uid'] = storeUid;
//     data['store_lat'] = storeLat;
//     data['store_lng'] = storeLng;
//     data['storeName'] = storeName;
//     return data;
//   }
// }

class Item {
  String? _cat;
  String? get cat => _cat;

  late List<Items> _items;
  List<Items> get items => _items;


  Item({required cat, required items}) {
    _cat = cat;
    _items = items;
  }

  Item.fromJson(Map<String, dynamic> json) {
    _cat = json['cat'];
    if (json['items'] != null) {
      _items = <Items>[];
      json['items'].forEach((v) {
        _items.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat'] = _cat;
    data['items'] = _items.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['itemName'] = itemName;
    data['itemDescription'] = itemDescription;
    data['price'] = price;
    data['itemImage'] = itemImage;
    data['itemCatId'] = itemCatId;
    data['status'] = status;
    data['storeId'] = storeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
