import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectionLost extends StatefulWidget {
  String? title;
  String? path;
  String? info;
  ConnectionLost({Key? key, this.title, this.path, this.info})
      : super(key: key);

  @override
  State<ConnectionLost> createState() => _ConnectionLostState();
}

class _ConnectionLostState extends State<ConnectionLost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
            Image.asset(widget.path!),
            const SizedBox(
              height: 20,
            ),
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
