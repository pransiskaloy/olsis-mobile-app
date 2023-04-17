import "package:flutter/material.dart";
import 'package:olsis/widgets/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR extends StatefulWidget {
  const QR({Key? key}) : super(key: key);

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
  String qrData = "1234567890";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * .9,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 250),
            decoration: const BoxDecoration(
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
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: QrImage(
                      data: qrData,
                      foregroundColor: UiConstants.textTitleColor,
                      padding: const EdgeInsets.all(30),
                      size: 300,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: const Text(
                      "This QR code is intended for use with the Connict SAS exclusively.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
