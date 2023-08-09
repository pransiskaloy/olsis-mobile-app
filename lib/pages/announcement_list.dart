import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:olsis/pages/announcement.dart';
import 'package:olsis/utils/assistants/auth.dart';
import 'package:olsis/utils/assistants/logMethod.dart';
import 'package:olsis/utils/assistants/methods.dart';
import 'package:olsis/widgets/announcement_tile.dart';
import 'package:olsis/widgets/constants.dart';
import '../widgets/connectivity.dart';
import '../widgets/bottomModal.dart';

class AnnouncementList extends StatefulWidget {
  const AnnouncementList({Key? key}) : super(key: key);

  @override
  State<AnnouncementList> createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  final AuthMethods _authMethod = AuthMethods();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ShowBottomModal showModal = ShowBottomModal();
  final AssistantMethods _assistantMethods = AssistantMethods();

  @override
  void initState() {
    super.initState();
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
    });
    if (_connectionStatus.toString() == "ConnectivityResult.none") {
      showModal.bottomModal(context, 'assets/animation/network.json',
          "DISCONNECTED", "Please check your internet connection!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Announcements",
          style: GoogleFonts.poppins(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(children: [
        FutureBuilder<List<dynamic>>(
          future: _authMethod.fetchAnnouncements(_connectionStatus.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return ConnectionLost(
                  title: "NOT AVAILABLE",
                  path: 'images/connectionLost.png',
                  info:
                      "Oops! \n Please check your internet connection to proceed!");
            } else if (snapshot.data?.isEmpty ?? true) {
              return ConnectionLost(
                  title: "CONNECTION LOST",
                  path: 'images/connectionLost.png',
                  info:
                      "Oops! \n Please check your internet connection to proceed!");
            } else {
              final List<dynamic> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final child = data[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: AnnouncementTile(
                        day: _assistantMethods.formatDay(child['created_at']!),
                        month:
                            _assistantMethods.formatMonth(child['created_at']!),
                        title: child['title'] ?? '[No Title]',
                        content: child['description']),
                  );
                },
              );
            }
          },
        )
      ]),
    );
  }
}

Route _createRoute(Widget currentScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => currentScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
