import 'dart:async';

import 'package:flutter/material.dart';
import 'package:olsis/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home.dart';
import '../utils/assistants/auth.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final AuthMethods _authMethods = AuthMethods();

  bool? isLoggedIn;
  startTimer() {
    Timer(const Duration(seconds: 2), () async {
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
    if (isLoggedIn == true) {
      _authMethods.getUserInfo();
      _authMethods.getAnnouncement(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: UiConstants.buttonFocusColor,
      backgroundColor: const Color(0xFF4395E7),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/sas-logo.png",
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width * .5,
                  ),
                  Image.asset(
                    "images/sas-wordv2.png",
                    height: 300,
                    width: MediaQuery.of(context).size.width * .5,
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
