import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/resources/colors.dart';

class PortfolioTheme {
  static get themeData => ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Open Sans',
        textTheme: TextTheme(
          headline6: GoogleFonts.openSans(
            fontSize: 36.0,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 3.0,
          ),
          headline2: GoogleFonts.openSans(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            letterSpacing: 2.0,
          ),
          headline3: GoogleFonts.openSans(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
            letterSpacing: 2.0,
          ),
          headline4: GoogleFonts.openSans(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            letterSpacing: 2.0,
          ),
          headline5: GoogleFonts.openSans(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            letterSpacing: 2.0,
          ),
          headline1: GoogleFonts.openSans(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 10.0,
          ),
          bodyText1: GoogleFonts.openSans(
            fontSize: 14.0,
            color: AppColors.black,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
