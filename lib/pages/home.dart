import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olsis/pages/payment.dart';
import 'package:olsis/pages/dashboard.dart';
import 'package:olsis/pages/logs.dart';
import 'package:olsis/pages/profile.dart';
import 'package:olsis/pages/qr.dart';
import 'package:olsis/widgets/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
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
                        currentScreen = Dashboard();
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
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: UiConstants.textSubTitleColor,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Payments();
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
                            ? Text(
                                "Paid",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: UiConstants.textSubTitleColor,
                                  ),
                                ),
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
                        currentScreen = Logs();
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
                            ? Text(
                                "Logs",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: UiConstants.textSubTitleColor,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
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
                            ? Text(
                                "Profile",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    color: UiConstants.textSubTitleColor,
                                  ),
                                ),
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
