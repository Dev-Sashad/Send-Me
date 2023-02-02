import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../_lib.dart';

class AppTheme {
  AppTheme._();

  /// The app was designed in a light theme mode so, there's no dark theme data
  /// for now
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.appBlue,
      background: AppColors.white,
      onBackground: AppColors.white,
      surface: AppColors.grey,
      onSurface: AppColors.grey,
    ),
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primaryColor,
    fontFamily: GoogleFonts.nunitoTextTheme().bodyText1!.fontFamily,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.josefinSans(
        fontSize: 32.sp,
        color: AppColors.headerTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.josefinSans(
        fontSize: 28.sp,
        color: AppColors.headerTextColor,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.ibmPlexSans(
        fontSize: 28.sp,
        color: AppColors.headerTextColor,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 20.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.headerTextColor,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 18.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.headerTextColor,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.headerTextColor,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.headerTextColor,
      ),
    ),
    buttonTheme:
        ButtonThemeData(buttonColor: AppColors.primaryColor, height: 58),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
