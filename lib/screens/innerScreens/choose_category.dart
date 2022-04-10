
import 'package:dash_user_app/widgets/category_item.dart';
import 'package:flutter/material.dart';


class ChooseCategory extends StatefulWidget {
  ChooseCategory({Key? key}) : super(key: key);

  static const String routeName = 'choose_category';

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose Category',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
        body: ListView(padding: EdgeInsets.only(bottom: 16.0),
            children: <Widget>[

          CategoryItem(
            size: size,
            image: 'assets/category_food.jpg',
            name: "Food",
          ),
          CategoryItem(
            size: size,
            image: 'assets/category_grocery.jpg',
            name: "Groceries",
          ),
          CategoryItem(
            size: size,
            image: 'assets/category_pharmacy.jpg',
            name: "Pharmacy",
          )
        ]));
  }
}
