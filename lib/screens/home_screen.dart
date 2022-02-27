import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_user2/dataHandler/appData.dart';
import 'package:dash_user2/newModels/stores.dart';
import 'package:dash_user2/screens/innerScreens/stores_screen.dart';
import 'package:dash_user2/widgets/store_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Position? position;
  // List<Placemark>? placemarks;

  // getCurrentLocation() async {
  //   Position newPosition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50),
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
                        // Navigator.pushNamedAndRemoveUntil(context,
                        //     ChooseLocation.routeName, (route) => false);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, ChooseCategory.routeName);
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
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('stores').snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          // gridDelegate:
                          //     SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 1,
                          //   childAspectRatio: 2 / 3,
                          //   crossAxisSpacing: 10,
                          //   mainAxisSpacing: 10,
                          // ),
                          itemBuilder: (context, index) {
                            Sellers model = Sellers.fromJson(
                                snapshot.data!.docs[index].data()!
                                    as Map<String, dynamic>);
                           
                            return StoreLists(model: model, context: context);
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
