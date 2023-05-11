import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:olsis/pages/login.dart';

import '../pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 30), () async {
      // Navigator.push(context, MaterialPageRoute(builder: (c) => const Home()));
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const LoginPage()));
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * .9,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 250),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/qr_background.png'),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    "Welcome to Connict",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    height: 120,
                    child: OverflowBox(
                      minHeight: 370,
                      maxHeight: 370,
                      child: Lottie.network(
                        'https://assets7.lottiefiles.com/packages/lf20_428q8vok/Morph Loading.json',
                        // width: 300,
                        // height: 300,
                      ),
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
