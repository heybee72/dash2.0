import 'package:dash_user2/models&providers/store.dart';
import 'package:dash_user2/screens/innerScreens/store_details.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreLists extends StatefulWidget {
  StoreLists({Key? key}) : super(key: key);

  @override
  _StoreListsState createState() => _StoreListsState();
}

class _StoreListsState extends State<StoreLists> {
  @override
  Widget build(BuildContext context) {
    final storeAttribute = Provider.of<Store>(context);
    return storeAttribute.isAvailable == true
        ? InkWell(
            onTap: () => Navigator.of(context)
                .pushNamed(StoreDetailScreen.routeName, arguments: storeAttribute.id),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      '${storeAttribute.storeImage}',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Opacity(
                      opacity: .6,
                      child: Container(
                        color: Constants.primary_color,
                      ),
                    ),
                    Center(
                      heightFactor: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Text(
                          "${storeAttribute.storeName}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                    Center(
                      heightFactor: 35,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _getTags(storeAttribute.storeTags),
                            ]),
                      ),
                    ),
                    Positioned(
                      bottom: 5.0,
                      right: 10.0,
                      child: Text(
                        "30-35 min(s)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _getTags(List<String> strings) {
    return new Row(
        children: strings
            .map((item) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text(
                    "${item}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                ))
            .toList());
  }
}
