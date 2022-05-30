import 'package:dash_user_app/controllers/items_controller.dart';
import 'package:dash_user_app/controllers/store_controller.dart';
import 'package:dash_user_app/controllers/store_param_controller.dart';
import 'package:dash_user_app/global/global.dart';
import 'package:dash_user_app/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class CategoryItem extends StatefulWidget {
  CategoryItem(
      {Key? key, required this.size, required this.image, required this.name})
      : super(key: key);
  final Size size;
  final String image;
  final String name;

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreParamController>(
      builder: (params) => InkWell(
        onTap: () async {
          params.updateParam(widget.name);

          setState(() {
            Get.find<ItemController>().getItemList('');
          });

          Get.to(BottomNavScreen(), transition: Transition.rightToLeftWithFade);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          width: widget.size.width,
          height: widget.size.height * .25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(children: <Widget>[
              Image.asset(
                widget.image,
                fit: BoxFit.cover,
                width: widget.size.width,
              ),
              Opacity(
                  opacity: .6,
                  child: Container(
                    color: Constants.primary_color,
                  )),
              Center(
                  child: Text(
                widget.name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0),
              ))
            ]),
          ),
        ),
      ),
    );
  }
}
