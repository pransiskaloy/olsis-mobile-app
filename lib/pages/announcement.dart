import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olsis/widgets/constants.dart';

class AnnouncementPage extends StatefulWidget {
  String? day;
  String? month;
  String? title;
  String? content;
  AnnouncementPage({Key? key, this.day, this.month, this.title, this.content})
      : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: UiConstants.backgroundColor,
        elevation: 0,
        title: Text("Announcement"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 57, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * .79,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3, 3),
                    color: Color.fromARGB(255, 126, 126, 126),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.title!,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: UiConstants.textTitleColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Flexible(
                    child: Text(
                      widget.content!,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: UiConstants.textSubTitleColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Flexible(
                    child: Text(
                      widget.month! + " " + widget.day!,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -25,
              right: 20,
              child: Image.asset(
                'images/announce_icon.png',
                height: 130,
                width: 130,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
