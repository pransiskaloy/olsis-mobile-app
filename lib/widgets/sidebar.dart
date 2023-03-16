import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({Key? key}) : super(key: key);

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF4073DE),
      child: SafeArea(
        child: Column(
          children: [
            const InfoCard(
              name: "Francis",
              level: "BSIT - 2nd Year",
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Divider(
                    color: Colors.white24,
                    height: 1,
                  ),
                ),
                ListTile(
                  title: Text(
                    "RECORDS AND ADMISSION",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(color: Colors.white38),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SidebarMenuButton(
                    tap: () {},
                    ico: CupertinoIcons.doc,
                    title: "Student Permanent Record"),
                SidebarMenuButton(
                    tap: () {},
                    ico: CupertinoIcons.doc_on_clipboard,
                    title: "Evaluation"),
                ListTile(
                  title: Text(
                    "SYSTEM",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(color: Colors.white38),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SidebarMenuButton(
                    tap: () {},
                    ico: CupertinoIcons.question_circle,
                    title: "FAQ"),
                SidebarMenuButton(
                    tap: () {},
                    ico: CupertinoIcons.info_circle,
                    title: "About"),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Divider(
                    color: Colors.white24,
                    height: 1,
                  ),
                ),
                SidebarMenuButton(
                    tap: () {}, ico: Icons.logout_rounded, title: "Logout"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget SidebarMenuButton({String? title, IconData? ico, tap}) {
  return ListTile(
    onTap: tap,
    leading: SizedBox(
      height: 34,
      width: 34,
      child: Icon(
        ico,
        color: Colors.white,
      ),
    ),
    title: Text(
      title!,
      style: GoogleFonts.montserrat(
        fontSize: 15,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.name, required this.level})
      : super(key: key);

  final String name, level;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person_alt_circle,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: GoogleFonts.dongle(
            textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 50,
          color: Colors.white,
          height: .5,
        )),
      ),
      subtitle: Text(
        level,
        style: GoogleFonts.dongle(
            textStyle: TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: 27,
          color: Colors.white,
          height: .5,
        )),
      ),
    );
  }
}
