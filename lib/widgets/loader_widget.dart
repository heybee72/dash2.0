import 'package:dash_user_app/utils/constants.dart';
import 'package:dash_user_app/utils/dimensions.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.height45 * 6,
          left: Dimensions.width20,
          right: Dimensions.width20),
      child: CircularProgressIndicator(color: Constants.secondary_color),
    );
  }
}
