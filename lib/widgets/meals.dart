import 'package:dash_user2/models&providers/cart.dart';
import 'package:dash_user2/models&providers/items.dart';
import 'package:dash_user2/screens/innerScreens/item_details_screen.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MealsWidget extends StatelessWidget {
  final String storeId;

  const MealsWidget({
    Key? key,
    required List<Item> item,
    required this.storeId,
  })  : _item = item,
        super(key: key);

  final List<Item> _item;

  @override
  Widget build(BuildContext context) {
    final cartAttribute = Provider.of<Cart>(context);

    final cartProvider = Provider.of<CartProvider>(context);

    return SliverFillRemaining(
      child: TabBarView(
        children: List<Widget>.generate(
          _item.length,
          (int i) {
            return ListView(
              children: List.generate(
                _item[i].storeItems.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ItemDetailsScreen.routeName,
                              arguments: {
                                'itemId': _item[i].storeItems[index]['id'],
                                'title': _item[i].storeItems[index]['title'],
                                'price': _item[i].storeItems[index]['price'],
                                'description': _item[i].storeItems[index]
                                    ['description'],
                                'image': _item[i].storeItems[index]['image'],
                                'storeId': storeId.toString(),
                              });
                        },
                        child: Row(
                          children: [
                            cartProvider.cartList.containsKey(
                                    _item[i].storeItems[index]['id'])
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Container(
                                        color: Colors.green,
                                        width: 5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7),
                                  )
                                : Container(),
                            Card(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0,
                                                          right: 4.0),
                                                  child: Text(
                                                    "${cartAttribute.quantity}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                color:
                                                    Constants.secondary_color,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "${_item[i].storeItems[index]['title']}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${_item[i].storeItems[index]['description']}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Constants.grey_color),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "₦ ${_item[i].storeItems[index]['price']}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      "${_item[i].storeItems[index]['image']}",
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 40,
                        thickness: 0.5,
                        color: Constants.grey_color,
                      ),
                    ],
                  ),
                ),
              ),
              // children: [
              //   Text(
              //     "${_item[i].storeItems[i]['title']}",
              //     style: TextStyle(
              //         fontSize: 16, color: Colors.black),
              //   ),
              // ],
            );
          },
        ),
      ),
    );
  }
}
