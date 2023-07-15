import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olsis/pages/logsChildren.dart';
import 'package:olsis/pages/logsPersonal.dart';
import 'package:olsis/pages/payment.dart';
import 'package:olsis/pages/dashboard.dart';
import 'package:olsis/pages/logs.dart';
import 'package:olsis/pages/profile.dart';
import 'package:olsis/pages/qr.dart';
import 'package:olsis/utils/global.dart';
import 'package:olsis/widgets/constants.dart';

import '../utils/assistants/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthMethods _authMethods = AuthMethods();
  int currentTab = 0;
  final List<Widget> screens = [
    const Dashboard(),
    const Payments(),
    const QR(),
    const Logs(),
    const Profile()
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = const Dashboard();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authMethods.getAnnouncement(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF44A0EB),
        child: SizedBox(
          height: 35,
          width: 35,
          child: Image.asset('images/qr.png'),
        ),
        onPressed: () {
          setState(() {
            currentScreen = const QR();
            currentTab = 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Dashboard();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard_rounded,
                          size: 35,
                          color: currentTab == 0
                              ? UiConstants.buttonFocusColor
                              : UiConstants.buttonUnfocusColor,
                        ),
                        currentTab == 0
                            ? Text(
                                "Home",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: UiConstants.textSubTitleColor)
                                // GoogleFonts.montserrat(
                                //   textStyle: TextStyle(
                                //     color: UiConstants.textSubTitleColor,
                                //   ),
                                // )
                                ,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Payments();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card_rounded,
                          size: 35,
                          color: currentTab == 1
                              ? UiConstants.buttonFocusColor
                              : UiConstants.buttonUnfocusColor,
                        ),
                        currentTab == 1
                            ? Text("Paid",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: UiConstants.textSubTitleColor)
                                // GoogleFonts.montserrat(
                                //   textStyle: TextStyle(
                                //     color: UiConstants.textSubTitleColor,
                                //   ),
                                // ),
                                )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = userModel.userType == "Parent"
                            ?
                            // const LogsChildren()
                            const Logs()
                            : LogsPersonal(
                                name: userModel.firstname, id: userModel.uuid);
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_rounded,
                          size: 35,
                          color: currentTab == 3
                              ? UiConstants.buttonFocusColor
                              : UiConstants.buttonUnfocusColor,
                        ),
                        currentTab == 3
                            ? Text("Logs",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: UiConstants.textSubTitleColor)
                                //  GoogleFonts.montserrat(
                                //   textStyle: TextStyle(
                                //     color: UiConstants.textSubTitleColor,
                                //   ),
                                // ),
                                )
                            : Container(),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Profile();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_rounded,
                          size: 35,
                          color: currentTab == 4
                              ? UiConstants.buttonFocusColor
                              : UiConstants.buttonUnfocusColor,
                        ),
                        currentTab == 4
                            ? Text("Profile",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: UiConstants.textSubTitleColor)
                                // GoogleFonts.montserrat(
                                //   textStyle: TextStyle(
                                //     color: UiConstants.textSubTitleColor,
                                //   ),
                                // ),
                                )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
