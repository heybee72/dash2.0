import 'package:dash_user2/dataHandler/appData.dart';
import 'package:dash_user2/models&providers/store.dart';
import 'package:dash_user2/screens/innerScreens/choose_category.dart';
import 'package:dash_user2/screens/innerScreens/select_location.dart';
import 'package:dash_user2/utils/constants.dart';
import 'package:dash_user2/utils/set_pref.dart';
import 'package:dash_user2/widgets/store_lists.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Stores extends StatefulWidget {
  Stores({Key? key}) : super(key: key);

  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);

    List<Store> storesList = storeProvider.stores();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.black, size: 16),
                          SizedBox(width: 5.0),
                          Provider.of<AppData>(context).pickUpLocation != null
                              ? Provider.of<AppData>(context)
                                          .pickUpLocation!
                                          .placeName!
                                          .length >
                                      20
                                  ? Text(
                                      "${Provider.of<AppData>(context).pickUpLocation!.placeName!.substring(0, 18)}...",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black))
                                  : Text(
                                      "${Provider.of<AppData>(context).pickUpLocation!.placeName!}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black))
                              : Text('Select Location',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.black),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            ChooseLocation.routeName, (route) => false);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ChooseCategory.routeName);
                      },
                      child: Row(
                        children: [
                          Text('Category',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: storesList[index],
                    child: StoreLists(),
                  );
                },
                itemCount: storesList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
