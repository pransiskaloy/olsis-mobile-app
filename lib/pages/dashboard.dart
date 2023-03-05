import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olsis/widgets/announcement.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 215,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/dashboard.png'),
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        child: Image.asset('images/menu.png'),
                        height: 40,
                        width: 40,
                      ),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Badge(
                        showBadge: true,
                        toAnimate: false,
                        badgeContent: Text(
                          '',
                          style: TextStyle(color: Colors.white),
                        ),
                        child: Container(
                          child: Image.asset('images/notification.png'),
                          height: 25,
                          width: 25,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome,',
                        style: GoogleFonts.dongle(
                          fontWeight: FontWeight.w100,
                          fontSize: 50,
                          textStyle: const TextStyle(
                              color: Color(0xFFD0ECF7), height: 0.5),
                        ),
                      ),
                    ),
                    Text(
                      'Francis!',
                      style: GoogleFonts.dongle(
                        fontWeight: FontWeight.bold,
                        fontSize: 90,
                        textStyle: const TextStyle(
                            color: Color(0xFFD0ECF7), height: 0.7),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ANNOUNCEMENT",
                          style: GoogleFonts.dongle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            textStyle: TextStyle(
                              height: 1,
                              color: Color.fromARGB(255, 124, 148, 233),
                            ),
                          ),
                        ),
                        Text(
                          "View All",
                          style: GoogleFonts.dongle(
                            fontWeight: FontWeight.w100,
                            fontSize: 25,
                            textStyle: TextStyle(
                              height: 1,
                              color: Color.fromARGB(255, 124, 148, 233),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Announcement Widget
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Announcement(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "CATEGORIES",
                    style: GoogleFonts.dongle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      textStyle: TextStyle(
                        height: 1,
                        color: Color.fromARGB(255, 124, 148, 233),
                      ),
                    ),
                  ),
                  //Categories Widget
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Announcement(),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
