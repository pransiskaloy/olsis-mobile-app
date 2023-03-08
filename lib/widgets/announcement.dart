import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olsis/widgets/constants.dart';

class Announcement extends StatefulWidget {
  String? day;
  String? month;
  String? title;
  String? content;

  Announcement({this.day, this.month, this.title, this.content});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  // String day = "27";
  // String month = "Mar";
  // String title = "TERM BREAK";
  // String content = "No class until April 19 up to 23";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(6, 6),
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 10.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 231, 246, 252),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(children: [
            Text(
              widget.day ?? "",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                textStyle: TextStyle(
                  color: UiConstants.textTitleColor,
                ),
              ),
            ),
            Text(
              widget.month ?? "",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                textStyle: TextStyle(
                  height: 1,
                  color: UiConstants.textTitleColor,
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title ?? "",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 27,
                textStyle: TextStyle(
                  height: 1,
                  color: UiConstants.textTitleColor,
                ),
              ),
            ),
            Text(
              widget.content?.substring(0, 20) ?? "",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
                fontSize: 17,
                textStyle: TextStyle(
                  height: 1.1,
                  color: UiConstants.textSubTitleColor,
                ),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            GestureDetector(
              child: const Text(
                "Read More . . .",
                style: TextStyle(
                  color: Color.fromARGB(255, 201, 201, 201),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
