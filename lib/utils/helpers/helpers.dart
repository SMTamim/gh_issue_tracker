import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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

  // format the date to human readable format
  static String issueCreatedOn(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

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

  // helper function to switch new screen and it clears the stack if required
  static void goToNextRoute(BuildContext context, Widget route,
      [bool clearStack = true]) {
    if (clearStack) {
      Navigator.pop(context);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  // make a string capitalize
  static String capitalizeText({required String text}) {
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  // format title string
  static String formattedTitle(String originalString, String textToReplace) {
    return originalString.replaceAll('%s', textToReplace);
  }
}
