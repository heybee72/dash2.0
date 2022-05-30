import 'package:dash_user_app/model/menu.dart';
import 'package:dash_user_app/screens/innerScreens/items_screen.dart';
import 'package:flutter/material.dart';

class InfoDesignWidget extends StatefulWidget {
  Menu? model;
  String? storeId;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context, this.storeId});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ItemsScreen(
              model: widget.model,
              storeId: widget.storeId,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.model!.menuImage!,
              width: 70,
            ),
          ),
          title: Text(widget.model!.menuTitle!),
          subtitle: Text(widget.model!.menuInfo!, maxLines: 2),
        ),
      ),
    );
  }
}
