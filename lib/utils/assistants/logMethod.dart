import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:olsis/utils/assistants/methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class LogMethod {
  Future<List<dynamic>> fetchChildren(String connectionResult) async {
    AssistantMethods _assistantMethods = AssistantMethods();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = await _assistantMethods.getPrefStringData("token");
    if (connectionResult != "ConnectivityResult.none") {
      final response = await http.get(
          Uri.parse('https://sas.connict.online/api/userAffiliate'),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        // API call successful
        var data = {};
        data = jsonDecode(response.body);
        pref.setString('childrenJsonKey', response.body.toString());
        // print('FETCH CHILD DATA - auth.dart 61');
        // print(response.body.toString());
        childList = data['data']['UserAffiliates'];
        return childList;
      } else {
        return childList;
      }
    } else {
      return childList;
    }
  }

  Future<List<dynamic>> fetchChildLogs(
      String connectionResult, String id) async {
    AssistantMethods _assistantMethods = AssistantMethods();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = await _assistantMethods.getPrefStringData("token");
    if (connectionResult != "ConnectivityResult.none") {
      var url = Uri.parse('https://sas.connict.online/api/qrLogsChild');

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'child_id': id}, // Pass the 'id' parameter in the request body
      );
      // print(response.body.toString());
      if (response.statusCode == 200) {
        // API call successful
        var data = {};
        data = jsonDecode(response.body);
        pref.setString('childQrJsonKey', response.body.toString());
        // print('FETCH CHILD DATA - auth.dart 61');
        print(response.body.toString());
        childQrList = data['data']['ChildQRLogs'];
        return childQrList;
      } else {
        return childQrList;
      }
    } else {
      return childQrList;
    }
  }
}
