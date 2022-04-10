import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String title;
  final VoidCallback? tIconCallback;
  final VoidCallback? onTap;
  String? subtitle;
  Color? color;
  Size? size;
  IconData? tIcon;

  UserListTile({
    this.tIconCallback,
    this.onTap,
    this.subtitle,
    this.color,
    this.size,
    this.tIcon,
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(0),
      ),
      margin: EdgeInsets.all(1.5),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListTile(
          title: Text(title,
              style: TextStyle(color: color != null ? Colors.grey[600] : null)),
          subtitle: subtitle != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    subtitle.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                )
              : null,
          onTap: onTap,
          trailing: IconButton(
            icon: Icon(tIcon, size: 15, color: Color(0xFFC4C4C4)),
            onPressed: tIconCallback,
          ),
        ),
      ),
    );
  }
}
