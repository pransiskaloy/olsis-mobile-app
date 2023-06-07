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
    _authMethods.getUserInfo();
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
      backgroundColor: const Color(0xFF4395E7),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Row(
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
            ),
          )
        ]),
      ),
    );
  }
}
