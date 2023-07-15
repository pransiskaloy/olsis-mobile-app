import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class AssistantMethods {
  static String getName(String sentence) {
    if (sentence.isNotEmpty) {
      final words = sentence.split(' ');
      if (words.isNotEmpty) {
        var name = words[0].toLowerCase();
        return name.replaceAll(name[0], name[0].toUpperCase());
      }
    }
    return '';
  }

  Future<String> getPrefStringData(data) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString(data) ?? '';
    return result;
  }

  Future<bool> getPrefBoolData(data) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool result = pref.getBool(data) ?? false;
    return result;
  }

  String formatMonth(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat format = DateFormat.MMM(); // Use MMMd() for "Jan" format
    return format.format(date);
  }

  String formatDay(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat format = DateFormat.d(); // Use MMMd() for "27" format
    return format.format(date);
  }

  String formatAnnouncementDay(String dateString) {
    print(dateString);
    try {
      // Extract year, month, and day from the date string
      int year = int.parse(dateString.substring(0, 4));
      int month = int.parse(dateString.substring(5, 7));
      int day = int.parse(dateString.substring(8, 10));
      // Create a DateTime object with the extracted values
      DateTime date = DateTime(year, month, day);
      DateFormat outputFormat = DateFormat.d(); // Use MMMd() for "27" format
      return outputFormat.format(date);
    } catch (e) {
      print('Invalid date format: formatAnnouncementDay $e');
      return '';
    }
  }

  String formatAnnouncementMonth(String dateString) {
    try {
      // Extract year, month, and day from the date string
      int year = int.parse(dateString.substring(0, 4));
      int month = int.parse(dateString.substring(5, 7));
      int day = int.parse(dateString.substring(8, 10));
      // Create a DateTime object with the extracted values
      DateTime date = DateTime(year, month, day);
      DateFormat format = DateFormat.MMM(); // Use MMMd() for "Jan" format
      return format.format(date);
    } catch (e) {
      print('Invalid date format: formatAnnouncementMonth $e');
      return '';
    }
  }

  String formatYear(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat format = DateFormat.y(); // Use MMMd() for "23" format
    return format.format(date);
  }

  String formatTime(String timeString) {
    // DateFormat format = DateFormat.Hm();
    // DateTime time = DateFormat("HH:mm:ss a").parse(timeString);
    // return format.format(time);
    DateFormat inputFormat = DateFormat("HH:mm:ss");
    DateFormat outputFormat = DateFormat("h:mm a");

    DateTime time = inputFormat.parse(timeString.replaceFirst(" ", ""));
    String formattedTime = outputFormat.format(time);

    return formattedTime;
  }
}
