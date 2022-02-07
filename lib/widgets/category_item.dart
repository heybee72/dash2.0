import 'package:dash_user2/screens/bottom_nav_screen.dart';
import 'package:dash_user2/utils/set_pref.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(PageTransition(
            child: BottomNavScreen(),
            type: PageTransitionType.rightToLeftWithFade));
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
    );
  }
}