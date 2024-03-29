import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olsis/pages/announcement_list.dart';
import '../pages/notification.dart';
import '../utils/assistants/auth.dart';
import '../utils/assistants/methods.dart';
import '../utils/global.dart';
import '../widgets/announcement_tile.dart';
import '../widgets/category.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthMethods _authMethods = AuthMethods();
  final AssistantMethods _assistantMethods = AssistantMethods();

  @override
  void initState() {
    super.initState();

    _authMethods.getAnnouncement(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 215,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/dashboard.png'),
              ),
            ),
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // GestureDetector(
                    //   child: Badge(
                    //     showBadge: true,
                    //     toAnimate: false,
                    //     badgeContent: const Text(
                    //       '',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     child: SizedBox(
                    //       child: Image.asset('images/notification.png'),
                    //       height: 25,
                    //       width: 25,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //       _createRoute(
                    //         const NotificationPage(),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(left: 40),
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
                      AssistantMethods.getName(userModel.firstname ?? ''),
                      style: GoogleFonts.dongle(
                        fontWeight: FontWeight.bold,
                        fontSize: 120,
                        textStyle: const TextStyle(
                            color: Color(0xFFD0ECF7), height: 0.7),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          const SizedBox(
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
                    padding: const EdgeInsets.only(right: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ANNOUNCEMENT",
                          style: GoogleFonts.dongle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            textStyle: const TextStyle(
                              height: 1,
                              color: Color.fromARGB(255, 124, 148, 233),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AnnouncementList()));
                          },
                          child: Text(
                            "View All",
                            style: GoogleFonts.dongle(
                              fontWeight: FontWeight.w100,
                              fontSize: 25,
                              textStyle: const TextStyle(
                                height: 1,
                                color: Color.fromARGB(255, 124, 148, 233),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Announcement Widget
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AnnouncementTile(
                        day: _assistantMethods
                            .formatDay(announcementModel.createdAt!),
                        month: _assistantMethods
                            .formatMonth(announcementModel.createdAt!),
                        title: announcementModel.title,
                        content: announcementModel.description),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Text(
          //           "CATEGORIES",
          //           style: GoogleFonts.dongle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 30,
          //             textStyle: const TextStyle(
          //               height: 1,
          //               color: Color.fromARGB(255, 124, 148, 233),
          //             ),
          //           ),
          //         ),
          //         //Categories Widget
          //         Padding(
          //           padding: const EdgeInsets.only(right: 20),
          //           child: Row(
          //             children: [
          //               Category(
          //                 image: Image.asset(
          //                   "images/balance.png",
          //                   height: 45,
          //                   width: 45,
          //                 ),
          //                 title: "Balance",
          //               ),
          //               Category(
          //                 image: Image.asset(
          //                   "images/enrollment.png",
          //                   height: 45,
          //                   width: 45,
          //                 ),
          //                 title: "Enrollment",
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}

Route _createRoute(Widget currentScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => currentScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
