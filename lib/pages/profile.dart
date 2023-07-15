import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/loading.dart';
import '../widgets/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import '../utils/assistants/methods.dart';
import '../utils/global.dart';
import '../widgets/bottomModal.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _token = "";

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ShowBottomModal showModal = ShowBottomModal();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      developer.log(_connectionStatus.toString());
      if (_connectionStatus.toString() == "ConnectivityResult.none") {
        showModal.bottomModal(context, 'assets/animation/network.json',
            "DISCONNECTED", "Please check your internet connection!");
      }
    });
  }

  void logout(String token) async {
    try {
      setLoggedIn(false, "none");

      Response response = await post(
          Uri.parse('https://sas.connict.online/api/logout'),
          headers: {'Authorization': 'Bearer $token'});

      final data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        setLoggedIn(false, "none");
      } else {
        setLoggedIn(true, token);
      }
    } catch (e) {
      developer.log(e.toString());
    }
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = (prefs.getString('token') ?? '');
    });
  }

  Future<void> setLoggedIn(loggedIn, token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLoggedIn", loggedIn);
    pref.setString("token", token);
    pref.setString("userJsonKey", '');
    if (loggedIn) {
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const SplashScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const LoadingScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4073DE),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            InfoCard(
              name: AssistantMethods.getName(userModel.firstname!),
              level: userModel.userType == "Parent"
                  ? schoolModel.name!
                  : "BSIT - 2nd Year",
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 20),
                  child: Divider(
                    color: Colors.white24,
                    height: 1,
                  ),
                ),
                ListTile(
                  title: Text(
                    "RECORDS AND ADMISSION",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(color: Colors.white38),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                sidebarMenuButton(
                    tap: () {},
                    ico: CupertinoIcons.doc,
                    title: "Student Permanent Record"),
                sidebarMenuButton(
                    tap: () {},
                    ico: CupertinoIcons.doc_on_clipboard,
                    title: "Evaluation"),
                ListTile(
                  title: Text(
                    "SYSTEM",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(color: Colors.white38),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                sidebarMenuButton(
                    tap: () {},
                    ico: CupertinoIcons.question_circle,
                    title: "FAQ"),
                sidebarMenuButton(
                    tap: () {},
                    ico: CupertinoIcons.info_circle,
                    title: "About"),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Divider(
                    color: Colors.white24,
                    height: 1,
                  ),
                ),
                sidebarMenuButton(
                    tap: () {
                      if (_connectionStatus.toString() ==
                          "ConnectivityResult.none") {
                        showModal.bottomModal(
                            context,
                            'assets/animation/network.json',
                            "DISCONNECTED",
                            "Please check your internet connection!");
                      } else {
                        logout(_token);
                      }
                    },
                    ico: Icons.logout_rounded,
                    title: "Logout"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget sidebarMenuButton({String? title, IconData? ico, tap}) {
  return ListTile(
    onTap: tap,
    leading: SizedBox(
      height: 34,
      width: 34,
      child: Icon(
        ico,
        color: Colors.white,
      ),
    ),
    title: Text(
      title!,
      style: GoogleFonts.montserrat(
        fontSize: 15,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.name, required this.level})
      : super(key: key);

  final String name, level;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 10),
            child: const CircleAvatar(
              radius: 29,
              backgroundColor: Colors.transparent,
              child: Icon(
                CupertinoIcons.person_alt_circle,
                size: 70,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.dongle(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                    color: Colors.white,
                    height: .5,
                  )),
                ),
                Text(
                  level,
                  style: GoogleFonts.dongle(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 30,
                    color: Colors.white,
                    height: .5,
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
