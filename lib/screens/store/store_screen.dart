import 'package:dash_user_app/controllers/store_controller.dart';
import 'package:dash_user_app/routes/route_helper.dart';
import 'package:dash_user_app/utils/colors.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/dimensions.dart';
import 'package:dash_user_app/widgets/loader_widget.dart';
import 'package:dash_user_app/widgets/no_delivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (stores) {
        return stores.isLoaded == false
            ? LoaderWidget()
            : stores.storeFound == true
                ? _store(stores)
                : NoDelivery();
      },
    );
  }

  Widget _store(StoreController stores) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: stores.storeList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getSingleStore(
                  index, stores.storeList[index].uid));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      stores.storeList[index].storeImage,
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
                      heightFactor: 7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Text(
                          stores.storeList[index].storeName,
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
