import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Notification",
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            NotificationPage(),
          ],
        ),
      ),
    );
  }
}
