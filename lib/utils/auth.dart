import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthMethods {
  static Future<bool> loginUser(username, password) async {
    bool isLogin;
    try {
      Response response = await post(
          Uri.parse('https://sas.connict.online/api/login'),
          body: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
        print(data);
        isLogin = true;
      } else {
        print('failed');
        isLogin = false;
      }
    } catch (e) {
      print(e.toString());
      isLogin = false;
    }
    return isLogin;
  }
}
