import 'package:flutter/material.dart';

class AppConstants {
  static const EdgeInsetsGeometry screenPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  static const Duration defaultLoadingDelay = Duration(milliseconds: 500);
  static const Duration searchTimerDuration = Duration(milliseconds: 1200);

  static const String commitScreenTitle = '%s Issue List';
  static const String commitScreenSearchLabel = 'Search Issues';
  static const String commitScreenSearchTextHint = 'Enter issue search term';
}
