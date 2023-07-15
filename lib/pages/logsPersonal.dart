import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/assistants/logMethod.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import '../utils/assistants/methods.dart';
import '../widgets/connectivity.dart';
import '../widgets/bottomModal.dart';
import '../widgets/constants.dart';

class LogsPersonal extends StatefulWidget {
  String? name;
  String? id;
  LogsPersonal({Key? key, this.name, this.id}) : super(key: key);

  @override
  State<LogsPersonal> createState() => _LogsPersonalState();
}

class _LogsPersonalState extends State<LogsPersonal> {
  final LogMethod _logMethod = LogMethod();
  final AssistantMethods _method = AssistantMethods();
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
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.name!,
          style: GoogleFonts.poppins(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(children: [
        FutureBuilder<List<dynamic>>(
          future: _logMethod.fetchChildLogs(
              _connectionStatus.toString(), widget.id!),
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
              // "Oops! \n Please check your internet connection to proceed!");
            } else if (snapshot.data?.isEmpty ?? true) {
              return ConnectionLost(
                  title: "MAINTENANCE",
                  path: 'images/fixing.png',
                  info:
                      "Oops! We're sorry! \n We are currently fixing this feature!");
            } else {
              final List<dynamic> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final child = data[index];
                  // return ListTile(
                  //   title: Text(child['childname']['firstname']),
                  // );
                  return Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(.5, .5),
                          color: Color.fromARGB(150, 240, 240, 240),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 231, 246, 252),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            // Text(
                            //   child['log_type']['title'] == 'in' ? 'IN' : 'OUT',
                            //   style: GoogleFonts.montserrat(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 30,
                            //     textStyle: TextStyle(
                            //       color: UiConstants.textTitleColor,
                            //     ),
                            //   ),
                            // ),
                            Text(
                              _method.formatDay(child['log_date']),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                textStyle: TextStyle(
                                  color: UiConstants.textTitleColor,
                                ),
                              ),
                            ),
                            Text(
                              _method.formatMonth(child['log_date']),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                textStyle: TextStyle(
                                  height: 1,
                                  color: UiConstants.textTitleColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            child['room_name']['title'],
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                              textStyle: TextStyle(
                                height: 1,
                                color: UiConstants.textTitleColor,
                              ),
                            ),
                          ),
                          Text(
                            _method.formatTime(child['log_time']),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              textStyle: TextStyle(
                                height: 1.1,
                                color: UiConstants.textSubTitleColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          child['log_type']['title'] == 'in'
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 231, 252, 233),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Text(
                                    'TIME IN',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      textStyle: TextStyle(
                                        color: UiConstants.textSuccess,
                                      ),
                                    ),
                                  ))
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 252, 231, 231),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Text(
                                    'TIME OUT',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      textStyle: TextStyle(
                                        color: UiConstants.textFail,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ]),
                  );
                },
              );
            }
          },
        ),
      ]),
    );
  }
}
