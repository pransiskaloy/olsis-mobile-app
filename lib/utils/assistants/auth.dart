import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:olsis/utils/assistants/methods.dart';
import 'package:olsis/utils/global.dart';
import 'package:olsis/utils/model/announcement_model.dart';
import 'package:olsis/utils/model/school_model.dart';
import 'package:olsis/widgets/toaster.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/loading.dart';
import '../../widgets/splash.dart';
import '../model/user_model.dart';

class AuthMethods {
  final Toaster _toaster = Toaster();
  static saveUserInfo(data) {
    schoolModel.name = data['data']['user']['school']['name'] ?? "";
    schoolModel.description =
        data['data']['user']['school']['description'] ?? "";
    schoolModel.address = data['data']['user']['school']['address'] ?? "";
    schoolModel.logo = data['data']['user']['school']['logo'] ?? "";
    schoolModel.withSims =
        int.parse(data['data']['user']['school']['with_sims'] ?? '0');
    schoolModel.withIdmaker =
        int.parse(data['data']['user']['school']['with_idmaker'] ?? '0');

    userModel.uuid = data['data']['user']['users_uuid'] ?? "";
    userModel.firstname = data['data']['user']['firstname'] ?? "";
    userModel.middlename = data['data']['user']['middlename'] ?? "";
    userModel.lastname = data['data']['user']['lastname'] ?? "";
    userModel.sex = data['data']['user']['sex'] ?? "";
    userModel.address = data['data']['user']['address'] ?? "";
    userModel.dateOfBirth = data['data']['user']['date_of_birth'] ?? "";
    userModel.placeOfBirth = data['data']['user']['place_of_birth'] ?? "";
    userModel.phone = data['data']['user']['contact_no'] ?? "";
    userModel.email = data['data']['user']['email'] ?? "";
    userModel.username = data['data']['user']['username'] ?? "";
    userModel.userType = data['data']['user']['user_type']['title'] ?? "";
    userModel.userImage = data['data']['user']['user_image'] ?? "";
    userModel.statusId = int.parse(data['data']['user']['status_id'] ?? '0');
    // student_id: data['data']['user'][''],
    userModel.olsisRefSac =
        int.parse(data['data']['user']['olsis_ref_sac'] ?? '0');
    userModel.olsisRefTable =
        int.parse(data['data']['user']['olsis_ref_table'] ?? '0');
    userModel.olsisRefId =
        int.parse(data['data']['user']['olsis_ref_id'] ?? '0');
  }

  Future<void> login(String username, password, context) async {
    var data = {};
    Response? response;

    try {
      response = await post(Uri.parse('https://sas.connict.online/api/login'),
          body: {'username': username, 'password': password});
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        setLoggedIn(true, data['data']['user']['token']['plainText'],
            response.body.toString());
        saveUserInfo(data);
        // getAnnouncement(data['data']['user']['token']['plainText'], context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const LoadingScreen()));
      } else {
        setLoggedIn(false, "none", '');
        SchoolModel();
        UserModel();
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const SplashScreen()));
      }
    } catch (e) {
      setLoggedIn(false, "none", '');
      _toaster.showToaster(context, e.toString(), "fail");
    }
  }

  Future<void> setLoggedIn(loggedIn, token, jsonData) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString('userJsonKey', jsonData);
    pref.setBool("isLoggedIn", loggedIn);
    pref.setString("token", token);
  }

  Future<void> getUserInfo() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // var data = {};
    // Response? response;
    String data = pref.getString('userJsonKey')!;
    if (data.isNotEmpty) {
      Map<String, dynamic> storedJsonData = jsonDecode(data);
      saveUserInfo(storedJsonData);
    }
    // response = await post(Uri.parse('https://sas.connict.online/api/userImage'),
    //     headers: {'Authorization': 'Bearer $token'});
    // data = jsonDecode(response.body.toString());
    // print(data);
  }

  Future<void> getAnnouncement(context) async {
    AssistantMethods _assistantMethods = AssistantMethods();
    String token = await _assistantMethods.getPrefStringData("token");
    var data = {};
    try {
      Response response = await get(
          Uri.parse('https://sas.connict.online/api/getAnnouncements'),
          headers: {'Authorization': 'Bearer $token'});
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        // this.title, this.description, this.createdAt

        // if ( data['data']['announcement']['status_id']== "1") {
        //   AnnouncementModel(
        //       createdAt: data['data']['announcement']['created_at'] ?? "",
        //       title: data['data']['announcement']['title'] ?? "No Title",
        //       description: data['data']['announcement']['description'] ?? "",
        //       statusId: data['data']['announcement']['status_id'] ?? "");
        // }
        announcementList = data['data']['announcement'];

        Map<String, dynamic> jsonMap = jsonDecode(response.body.toString());
        List<dynamic> announcements = jsonMap['data']['announcement'];

        dynamic filteredAnnouncement = announcements.firstWhere(
            (announcement) => announcement['status_id'] == '1',
            orElse: () => null);

        announcementModel.createdAt = filteredAnnouncement['created_at'];
        announcementModel.title = filteredAnnouncement['title'] ?? '[No Title]';
        announcementModel.description = filteredAnnouncement['description'];
        announcementModel.statusId = filteredAnnouncement['status_id'];
      } else {
        _toaster.showToaster(context, "Announcement Load failed!", "fail");
      }
    } catch (e) {
      data = {};
      _toaster.showToaster(context, "Announcement Load failed!", "fail");
    }
  }

  Future<List<dynamic>> fetchAnnouncements(String connectionResult) async {
    AssistantMethods _assistantMethods = AssistantMethods();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = await _assistantMethods.getPrefStringData("token");
    if (connectionResult != "ConnectivityResult.none") {
      final response = await get(
          Uri.parse('https://sas.connict.online/api/getAnnouncements'),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        // API call successful
        var data = {};
        data = jsonDecode(response.body);
        pref.setString('childrenJsonKey', response.body.toString());
        // print('FETCH CHILD DATA - auth.dart 61');
        print(data['data']['announcement']);
        announcementList = data['data']['announcement'];
        return announcementList;
      } else {
        return announcementList;
      }
    } else {
      return announcementList;
    }
  }
}
