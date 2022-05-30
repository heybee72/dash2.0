// import 'package:dash_user_app/screens/innerScreens/stores_screen.dart';
import 'package:dash_user_app/controllers/store_controller.dart';
import 'package:dash_user_app/controllers/store_param_controller.dart';
import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/dimensions.dart';
import 'package:dash_user_app/widgets/select_location.dart';
import 'package:dash_user_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'innerScreens/choose_location.dart';
import 'store/store_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
    setState(() {
      Get.find<StoreController>().getStoreList();
    });
  }

  void didChangeDependencies() {
    // Theme.of(context)
    super.didChangeDependencies();
    setState(() {
      Get.find<StoreController>().getStoreList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height45 + 10,
                      bottom: Dimensions.height15),
                  padding: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: GetBuilder<StoreParamController>(
                    builder: (param) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20 / 2),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-5, 0),
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(5, 0),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white70,
                              onPrimary: Colors.white,
                              elevation: 0,
                            ),
                            onPressed: () {
                              // Navigator.of(context)
                              // .pushNamed(ChooseLocation.routeName);
                              Get.to(ChooseLocation());

                              // Get.offAllNamed(ChooseLocation.routeName);
                            },
                            child: Row(
                              children: [
                                SmallText(
                                  text: param.getParamAddress(),
                                  color: Colors.black54,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width20,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: param.getParamCategory(),
                              color: Colors.black54,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GetBuilder<StoreParamController>(
                  builder: (param) {
                    if (param.getParamAddress() == "Enter Address") {
                      return SelectLocation();
                    }
                    return Expanded(
                      child: SingleChildScrollView(child: StoreScreen()),
                    );
                  },
                ),
              ],
            ),
    );  
  }
}
