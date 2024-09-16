import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/constants/app_theme.dart';
import 'package:gh_issue_tracker/screens/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Issue Tracker',

      theme: AppThemes.themeData,
      navigatorKey: navigatorKey,
      home: const HomeScreen(),
    );
  }
}
