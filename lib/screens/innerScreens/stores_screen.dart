import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user_app/dataHandler/app_data.dart';
import 'package:dash_user_app/global/global.dart';
import 'package:dash_user_app/models&providers/store.dart';
import 'package:dash_user_app/new_models/data_class.dart';
import 'package:dash_user_app/new_models/store_model.dart';
import 'package:dash_user_app/new_provider/store_provider.dart';
import 'package:dash_user_app/screens/innerScreens/choose_category.dart';
import 'package:dash_user_app/screens/innerScreens/select_location.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/set_pref.dart';
import 'package:dash_user_app/widgets/empty_cart.dart';
import 'package:dash_user_app/widgets/no_delivery.dart';
import 'package:dash_user_app/widgets/select_location.dart';
import 'package:dash_user_app/widgets/store_lists.dart';
import 'package:dash_user_app/widgets/store_top_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stores extends StatefulWidget {
  Stores({Key? key}) : super(key: key);

  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  String category = '';
  String selected_location = '';
  double selected_lat = 0.0;
  double selected_lng = 0.0;

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefCat = prefs.getString('prefCat');
    // String? selected_location = prefs.getString('selected_location');
    // double? selected_lat = prefs.getDouble('selected_lat');
    // double? selected_lng = prefs.getDouble('selected_lng');

    if (prefCat != null) {
      setState(() {
        category = prefCat;
      });
    } else {
      setState(() {
        category = 'Select Category';
      });
    }
  }

  initState() {
    super.initState();
    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    selected_lat =
        Provider.of<AppData>(context).deliveryLocation?.latitude ?? 0.0;
    selected_lng =
        Provider.of<AppData>(context).deliveryLocation?.longitude ?? 0.0;

    print("selected_lat2: " + selected_lat.toString());
    print("selected_lng2: " + selected_lng.toString());
    // var storeModel = Provider.of<List<StoreModels>>(context, listen: false);
    final storeModel = Provider.of<StoreModels>(context, listen: false)
        .fetchAndSetStore(cat: category, lat: selected_lat, lng: selected_lng);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: RefreshIndicator(
          onRefresh: () async {
            print("refreshing");
            await Provider.of<StoreModels>(context, listen: false)
                .fetchAndSetStore(
                    cat: category, lat: selected_lat, lng: selected_lng);
          },
          child: Column(
            children: [
              TopBar(category: category),
              Expanded(
                // child: Container(),
                child: Provider.of<AppData>(context).deliveryLocation == null
                    ? SelectLocation()
                    : storeModel == 0
                        ? NoDelivery()
                        : FutureBuilder(
                            future: storeModel,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Transform.scale(
                                      scale: 0.5,
                                      child: CircularProgressIndicator()),
                                );
                              } else {
                                if (snapshot.error != null) {
                                  return const Center(
                                    child: Text("sorry an error occured"),
                                  );
                                } else {
                                  return Consumer<StoreModels>(
                                      builder: (context, storeModel, _) {
                                    print(storeModel.storeModels.length);
                                    int countStore =
                                        storeModel.storeModels.length;
                                    return countStore == 0
                                        ? NoDelivery()
                                        : ListView.builder(
                                            itemCount:
                                                storeModel.storeModels.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 8.0),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 150,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Image.network(
                                                        '${storeModel.storeModels[index].storeImage}',
                                                        fit: BoxFit.cover,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                      ),
                                                      Opacity(
                                                        opacity: .6,
                                                        child: Container(
                                                          color: Constants
                                                              .primary_color,
                                                        ),
                                                      ),
                                                      Center(
                                                        heightFactor: 5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 16.0,
                                                                  right: 16.0),
                                                          child: Text(
                                                            "${storeModel.storeModels[index].storeName}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        heightFactor: 35,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 16.0),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: []),
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
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                  });
                                }
                              }

                              // return NoDelivery();
                            },
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
