import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.white,
    textTheme: TextTheme(
      bodyMedium: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 17,
          fontFamily: GoogleFonts.sourceSans3().fontFamily),
      bodyLarge: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 24,
          fontFamily: GoogleFonts.sourceSans3().fontFamily),
      bodySmall: TextStyle(
          color: AppColors.secondaryTextColor,
          fontSize: 12,
          fontFamily: GoogleFonts.sourceCodePro().fontFamily),
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryTextColor),
    dividerColor: AppColors.defaultDividerColor,
  );
}
