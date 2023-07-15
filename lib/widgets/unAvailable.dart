import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class UnAvailable extends StatefulWidget {
  String? title;
  String? lottie;
  String? info;
  UnAvailable({this.title, this.lottie, this.info});

  @override
  State<UnAvailable> createState() => _UnAvailableState();
}

class _UnAvailableState extends State<UnAvailable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Lottie.asset(widget.lottie!, height: 330, width: 330),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.title!,
              style: GoogleFonts.dongle(
                fontWeight: FontWeight.bold,
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                    height: 0.5,
                    fontSize: 60),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.info!,
              textAlign: TextAlign.center,
              style: GoogleFonts.dongle(
                fontWeight: FontWeight.w100,
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 105, 103, 103),
                    height: 0.5,
                    fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
