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

  static String issueCreatedOn(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    log('difference: ${difference.inDays.toString()}');
    if (difference.inDays < 1) {
      return DateFormat('hh:mm').format(dateTime);
    } else if (difference.inDays < 2) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('MM/dd/yy').format(dateTime);
    }
  }
}
