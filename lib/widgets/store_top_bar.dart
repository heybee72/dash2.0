import 'package:dash_user_app/dataHandler/app_data.dart';
import 'package:dash_user_app/screens/innerScreens/choose_category.dart';
import 'package:dash_user_app/screens/innerScreens/select_location.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Icon(Icons.location_on, color: Colors.black, size: 16),
                  SizedBox(width: 5.0),
                  Text(
                    Provider.of<AppData>(context).deliveryLocation != null
                        ? "${Provider.of<AppData>(context).deliveryLocation!.placeName!}"
                        : "Select Location",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Constants.grey_color,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
                ],
              ),
              onPressed: () async {
                // SharedPreferences preferences =
                //     await SharedPreferences.getInstance();
                // await preferences.remove('selected_location');
                // await preferences.remove('selected_lat');
                // await preferences.remove('selected_lng');
                // await preferences.remove('prefCat');
                Navigator.pushNamed(context, ChooseLocation.routeName);
              },
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, ChooseCategory.routeName);
            },
            child: Row(
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
