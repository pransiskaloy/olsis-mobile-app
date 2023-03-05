import "package:flutter/material.dart";
import 'package:qr_flutter/qr_flutter.dart';

class QR extends StatefulWidget {
  const QR({Key? key}) : super(key: key);

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
  String data = "1234567890";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/qr_background.png'),
              ),
            ),
            child: Center(
                child: QrImage(
              data: data,
              backgroundColor: Colors.white,
              size: 300,
            )),
          )
        ]),
      ),
    );
  }
}
