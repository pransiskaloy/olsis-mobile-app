import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olsis/widgets/constants.dart';
import '../pages/logsPersonal.dart';
import '../utils/assistants/logMethod.dart';

import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import '../widgets/connectivity.dart';
import '../widgets/bottomModal.dart';

class LogsChildren extends StatefulWidget {
  const LogsChildren({Key? key}) : super(key: key);

  @override
  State<LogsChildren> createState() => _LogsChildrenState();
}

class _LogsChildrenState extends State<LogsChildren> {
  final LogMethod _logMethod = LogMethod();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ShowBottomModal showModal = ShowBottomModal();

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
      // backgroundColor: ,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Student Logs",
          style: GoogleFonts.poppins(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(children: [
        FutureBuilder<List<dynamic>>(
          future: _logMethod.fetchChildren(_connectionStatus.toString()),
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
                  // return ListTile(
                  //   title: Text(child['childname']['firstname']),
                  // );
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => LogsPersonal(
                              name: child['childname']['firstname'],
                              id: child['childname']['child_id'])));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      margin:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        // color: UiConstants.buttonFocusColor,
                        // border: Border.all(
                        //   color: child['qla_is_notified'] == '1'
                        //       ? Colors.blue
                        //       : Colors.transparent,
                        //   width: 1.0,
                        // ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(.5, .5),
                            color: Color.fromARGB(150, 240, 240, 240),
                            spreadRadius: 1,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          getChildSex(child),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                child['childname']['firstname'] +
                                    " " +
                                    child['childname']['lastname'],
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color: UiConstants.buttonFocusColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              getChildDetailsWidget(child),
                            ],
                          ),
                        ],
                      ),
                    ),
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

Widget getChildDetailsWidget(Map<String, dynamic> child) {
  if (child != null &&
      child['childname'] != null &&
      child['childname']['moreDetails'] != null) {
    String course = child['childname']['moreDetails']['course'];
    String level = child['childname']['moreDetails']['level'];

    return Text(
      '$course $level',
      textAlign: TextAlign.justify,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 15, color: Colors.blue),
      ),
    );
  } else {
    return Text('');
  }
}

Widget getChildSex(Map<String, dynamic> child) {
  if (child != null &&
      child['childname'] != null &&
      child['childname']['moreDetails'] != null) {
    String sex = child['childname']['moreDetails']['sex'];
    String female = 'images/female.png';
    String male = 'images/male.png';
    return Image.asset(
      sex == "Male" ? male : female,
      width: 70,
      height: 70,
      fit: BoxFit.contain,
    );
  } else {
    return Image.asset(
      'images/unknown.png',
      width: 70,
      height: 70,
      fit: BoxFit.contain,
    );
  }
}
