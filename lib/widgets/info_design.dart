import 'package:dash_store/model/menu.dart';
import 'package:flutter/material.dart';

class InfoDesignWidget extends StatefulWidget {
  Menu? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
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
