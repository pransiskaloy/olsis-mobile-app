import 'package:flutter/material.dart';
import 'package:olsis/pages/home.dart';
import 'package:olsis/pages/login.dart';
import 'package:olsis/widgets/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          // child: LoginPage(),
          child: SplashScreen(),
        ),
      ),
    );
  }
}

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Get Started Page'));
  }
}
