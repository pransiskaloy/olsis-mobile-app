import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/logsChildren.dart';
import '../pages/logsPersonal.dart';
import '../widgets/constants.dart';
import '../utils/global.dart';

class Logs extends StatefulWidget {
  const Logs({Key? key}) : super(key: key);

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('images/attendance.png'),
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: Column(
                          children: [
                            Text(
                              "Attendance Logs",
                              style: GoogleFonts.dongle(
                                fontWeight: FontWeight.bold,
                                fontSize: 55,
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .35,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height * .29,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue,
                            Color.fromARGB(255, 92, 111, 180),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(-3, 3),
                            color: Color.fromARGB(255, 180, 180, 180),
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 20,
                      child: Image.asset(
                        'images/personal.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              "PERSONAL LOGS",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LogsPersonal(
                                          name: userModel.firstname,
                                          id: userModel.uuid)));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: UiConstants.buttonFocusColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(50), // <-- Radius
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * .2,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "View",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .35,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height * .29,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.red,
                            Color.fromARGB(255, 199, 86, 86)
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(3, 3),
                            color: Color.fromARGB(255, 180, 180, 180),
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 20,
                      child: Image.asset(
                        'images/children.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 10,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LogsChildren()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red[400],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(50), // <-- Radius
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * .2,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "View",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              "CHILDREN LOGS",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
