import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:olsis/pages/login.dart';
import 'package:olsis/widgets/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool? isLoggedIn;
  startTimer() {
    Timer(const Duration(seconds: 10), () async {
      if (isLoggedIn == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const LoginPage()));
      } else {
        if (isLoggedIn!) {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const Home()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const LoginPage()));
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isLogged();
    startTimer();
  }

  void isLogged() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = pref.getBool('isLoggedIn');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: UiConstants.buttonFocusColor,
      backgroundColor: const Color(0xFF125E9A),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // Lottie.network(
                  //     'https://assets9.lottiefiles.com/private_files/lf30_TBKozE.json'),
                  Row(
                    children: [
                      const Spacer(),
                      Image.asset(
                        "images/sas-logo.png",
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "images/sas-word.png",
                        height: 150,
                        width: 150,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    child: OverflowBox(
                      minHeight: 300,
                      maxHeight: 300,
                      child:
                          // Lottie.network('https://assets4.lottiefiles.com/packages/lf20_hnizzohr.json',),
                          Lottie.asset('assets/animation/loading.json'),
                    ),
                  ),
                  const Text(
                    "Loading . . . .",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
