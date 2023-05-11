import 'package:flutter/material.dart';

class NotificationTile extends StatefulWidget {
  String? day;
  String? month;
  String? type;
  String? name;
  String? content;

  NotificationTile(
      {Key? key, this.day, this.month, this.type, this.name, this.content})
      : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Text("Notification Tiles");
  }
}
