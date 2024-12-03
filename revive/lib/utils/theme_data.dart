import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revive/utils/constants.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    hoverColor: Colors.white,
    primaryColor: kPrimary,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      elevation: 0,
      titleTextStyle: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24
      ),
    ),
    iconTheme: IconThemeData(
        color: Colors.white
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displaySmall: TextStyle(
        color: kCard,
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        letterSpacing: -0.20,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        letterSpacing: -0.20,
      ),
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        letterSpacing: -0.20,
      ),
      bodyLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 16
      ),
      bodyMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 24
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        letterSpacing: -0.12,
      ),
      titleSmall: TextStyle(
        color: Color(0xFF5E6366),
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.20,
      ),
      labelLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 24
      ),
      labelMedium: GoogleFonts.inter(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 1,
      ),
      labelSmall: GoogleFonts.inter(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        letterSpacing: 1,
      ),
    ),
  );
}