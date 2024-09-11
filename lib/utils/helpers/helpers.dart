import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';

class Helper {
  static void indentedLog(dynamic response) {
    log(const JsonEncoder.withIndent('   ').convert(response.toJson()));
  }

  static String MMMddyyyyFormattedDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String dateAndTimeFormattedDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy  -  hh:mm a').format(date);
  }

  static String hhmmaTimeFormat(String dateTimeString) {
    DateTime date = DateTime.parse(dateTimeString);
    return DateFormat('hh:mm a').format(date);
  }
}
