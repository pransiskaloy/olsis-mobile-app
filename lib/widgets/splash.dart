import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:olsis/pages/login.dart';
import 'package:olsis/widgets/constants.dart';
import 'package:olsis/widgets/getStarted.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home.dart';
import '../utils/assistants/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthMethods _authMethods = AuthMethods();
  bool? isLoggedIn;

  startTimer() {
    Timer(const Duration(seconds: 5), () async {
      if (isLoggedIn == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (c) => const GetStartedScreen()));
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
    // _authMethods.getUserInfo();
    startTimer();
  }

  void isLogged() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = pref.getBool('isLoggedIn');
    });
    if (isLoggedIn == true) {
      _authMethods.getUserInfo();
      _authMethods.getAnnouncement(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiConstants.buttonFocusColor,
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child:
                      // Lottie.network('https://assets9.lottiefiles.com/private_files/lf30_TBKozE.json'),
                      Lottie.asset('assets/animation/welcome.json'),
                ),
                const SizedBox(
                  height: 50,
                ),
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
              ],
            ),
          ),
        )
      ]),
    );
  }
}
