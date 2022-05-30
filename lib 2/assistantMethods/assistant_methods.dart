import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dash_user_app/assistantMethods/total_amount.dart';
import 'package:dash_user_app/global/global.dart';
import 'package:dash_user_app/screens/auth/auth_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'cart_item_counter.dart';

separateItemIds() {
  List<String> separateItemIdList = [], defaultItemList = [];
  int i = 0;
  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    separateItemIdList.add(getItemId);
  }

  return separateItemIdList;
}

separateItemQtys() {
  List<int> separateQtyList = [];
  List<String> defaultItemList = [];
  int i = 1;
  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();

    List<String> listItemChars = item.split(":").toList();
    var quantityNumber = int.parse(listItemChars[1].toString());

    print("\n this is the Quantity::::" + quantityNumber.toString());

    separateQtyList.add(quantityNumber);
  }

  return separateQtyList;
}

addItemToCart(String? foodItemId, BuildContext context, int itemCounter) {
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! +
      ":$itemCounter"); //data is saved in the form of foodItemId:itemCounter
  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({
    "userCart": tempList,
  }).then((value) {
    Fluttertoast.showToast(
        msg: "Item added to cart",
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    sharedPreferences!.setStringList("userCart", tempList);
  });
}

updateItemToCart(String? foodItemId, BuildContext context, int itemCounter) {
  //  final numbers = <String>['garbageValue', '1646900879737:2'];

  //  numbers.removeWhere((item) => item == 1646900879737:2);
  //  print(numbers);

  // [three, four]
  List<String>? tempList = sharedPreferences!.getStringList("userCart");

  tempList!
      .removeWhere((item) => item.lastIndexOf(":") == foodItemId.toString());

  // // sharedPreferences!.setStringList('userCart', tempList);

  // // tempList.add("garbageValue");
  print("\n this is the tempList::::" + tempList.toString());

  // tempList!.add(foodItemId! +
  //     ":$itemCounter"); //data is saved in the form of foodItemId:itemCounter
  // FirebaseFirestore.instance
  //     .collection("users")
  //     .doc(firebaseAuth.currentUser!.uid)
  //     .update({
  //   "userCart": tempList,
  // }).then((value) {
  //   Fluttertoast.showToast(
  //       msg: "Item added to cart",
  //       backgroundColor: Colors.black,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  //   sharedPreferences!.setStringList("userCart", tempList);
  // });
}

clearCartNow(context) {
  sharedPreferences!.setStringList('userCart', ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList('userCart');

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({
    "userCart": emptyList,
  }).then((value) {
    sharedPreferences!.setStringList('userCart', emptyList!);

    Provider.of<CartItemCounter>(context, listen: false)
        .displaycartListItemNumber();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AuthStateScreen();
    }));

    if (sharedPreferences!.containsKey('cost')) {
      sharedPreferences!.setDouble('cost', 0.00);
      sharedPreferences!.reload();
    }

    Fluttertoast.showToast(
        msg: "Cart cleared",
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  });
}
