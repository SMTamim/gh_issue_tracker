import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class InternetConnectionException implements Exception {
  final String message;
  InternetConnectionException({required this.message});

  @override
  String toString() => 'InternetConnectionException: $message';
}

class ResponseStatusCodeException implements Exception {
  final int statusCode;
  final String message;

  ResponseStatusCodeException(
      {required this.statusCode, required this.message});

  @override
  String toString() =>
      'ResponseStatusCodeException: $message (Code: $statusCode)';
}

bool isBool(String value) {
  return value.toLowerCase() == 'true' || value.toLowerCase() == 'false';
}

class APIHelper {
  static Future<void> preAPICallCheck() async {
    // Check internet connection
    final bool isConnectedToInternet = await isConnectedInternet();
    log('isConnectedToInternet: $isConnectedToInternet');
    if (!isConnectedToInternet) {
      throw InternetConnectionException(message: 'Not connected to internet');
    }
  }

  // Method to check internet connection using connectivity_plus
  static Future<bool> isConnectedInternet() async {
    
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult[0] != ConnectivityResult.none;
  }

  static bool isResponseStatusCodeIn400(int? statusCode) {
    try {
      return (statusCode! >= 400 && statusCode < 500);
    } catch (e) {
      return false;
    }
  }

  static void postAPICallCheck(http.Response response) {
    // Handle null response status
    if (response.statusCode != 200 &&
        !isResponseStatusCodeIn400(response.statusCode)) {
      throw ResponseStatusCodeException(
        statusCode: response.statusCode,
        message: 'Response code is not valid',
      );
    }

    // Parse response body and check its type
    final dynamic responseBody = json.decode(response.body);
    if (responseBody == null) {
      throw Exception('responseBody is null');
    }
    if (responseBody is! Map<String, dynamic> &&
        responseBody is! List<dynamic>) {
      throw const FormatException('Response type is not Map<String, dynamic>');
    }
  }

  // static Map<String, String> getAuthHeaderMap() {
  //   String loggedInUserBearerToken = Helper.getUserBearerToken();
  //   return {'Authorization': loggedInUserBearerToken};
  // }

  static void handleExceptions(Object? exception) {
    /// API error exception of "connection timed out" handling
    if (exception is InternetConnectionException) {
      Fluttertoast.showToast(msg: exception.message);
    } else if (exception is SocketException) {
      log(exception.message);
    } else if (exception is FormatException) {
      log(exception.message);
    } else {
      log(exception.toString());
    }
  }

  static String getSafeStringValue(Object? unsafeResponseStringValue) {
    const String defaultStringValue = '';
    if (unsafeResponseStringValue == null) {
      return defaultStringValue;
    } else if (unsafeResponseStringValue is String) {
      // Now it is safe
      return unsafeResponseStringValue;
    }
    return defaultStringValue;
  }

  static List<T> getSafeListValue<T>(Object? unsafeResponseListValue) {
    const List<T> defaultListValue = [];
    if (unsafeResponseListValue == null) {
      return defaultListValue;
    } else if (unsafeResponseListValue is List<T>) {
      // Now it is safe
      return unsafeResponseListValue;
    }
    return defaultListValue;
  }

  static TimeOfDay getSafeTimeOfDayValue(
      Object? unsafeResponseTimeStringValue) {
    const TimeOfDay defaultTimeOfDay = TimeOfDay(hour: 0, minute: 0);
    if (unsafeResponseTimeStringValue == null) {
      return defaultTimeOfDay;
    } else if (unsafeResponseTimeStringValue is String) {
      final List<String> parts = unsafeResponseTimeStringValue.split(':');
      if (parts.length == 2) {
        final int? hour = int.tryParse(parts[0]);
        final int? minute = int.tryParse(parts[1]);
        if (hour != null && minute != null) {
          return TimeOfDay(hour: hour, minute: minute);
        }
      }
    } else if (unsafeResponseTimeStringValue is TimeOfDay) {
      return unsafeResponseTimeStringValue;
    }
    return defaultTimeOfDay;
  }

  static int getSafeIntValue(Object? unsafeResponseIntValue,
      [int defaultIntValue = -1]) {
    if (unsafeResponseIntValue == null) {
      return defaultIntValue;
    } else if (unsafeResponseIntValue is String) {
      return (num.tryParse(unsafeResponseIntValue) ?? defaultIntValue).toInt();
    } else if (unsafeResponseIntValue is num) {
      // Now it is safe
      return unsafeResponseIntValue.toInt();
    }
    return defaultIntValue;
  }

  static double getSafeDoubleValue(Object? unsafeResponseDoubleValue,
      [double defaultDoubleValue = -1]) {
    if (unsafeResponseDoubleValue == null) {
      return defaultDoubleValue;
    } else if (unsafeResponseDoubleValue is String) {
      return (num.tryParse(unsafeResponseDoubleValue) ?? defaultDoubleValue)
          .toDouble();
    } else if (unsafeResponseDoubleValue is num) {
      // Now it is safe
      return unsafeResponseDoubleValue.toDouble();
    }
    return defaultDoubleValue;
  }

  static bool? getBoolFromString(String boolAsString) {
    if (boolAsString == 'true') {
      return true;
    } else if (boolAsString == 'false') {
      return false;
    }
    return null;
  }

  static bool getSafeBoolValue(Object? unsafeResponseBoolValue,
      [bool defaultBoolValue = false]) {
    if (unsafeResponseBoolValue == null) {
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is String) {
      if (isBool(unsafeResponseBoolValue)) {
        return getBoolFromString(unsafeResponseBoolValue) ?? defaultBoolValue;
      }
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is bool) {
      // Now it is safe
      return unsafeResponseBoolValue;
    }
    return defaultBoolValue;
  }

  static String toTimeOfDayToString24HourFormat(TimeOfDay timeOfDay) {
    final String hour = timeOfDay.hour.toString().padLeft(2, '0');
    final String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

/*
  static APIResponseObject getSafeResponseObject(Object? unsafeResponseValue) {
    final APIResponseObject defaultValue = APIResponseObject();
    if (unsafeResponseValue == null) {
      return defaultValue;
    } else if (unsafeResponseValue is Map<String, dynamic>) {
      // Now it is safe
      return APIResponseObject.fromJson(unsafeResponseValue);
    }
    return defaultValue;
  }
 */
  static bool isAPIResponseObjectSafe<T>(Object? unsafeValue) {
    // log(unsafeValue.toString());
    // log('type: ${unsafeValue.runtimeType.toString()}');
    if (unsafeValue is Map<String, dynamic> || unsafeValue is List<dynamic>) {
      // Now it is safe
      return true;
    }
    return false;
  }
}
