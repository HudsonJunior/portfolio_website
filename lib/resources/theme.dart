import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/colors.dart';

class PortfolioTheme {
  static get themeData => ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Caviar',
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 36.0,
            fontFamily: 'LouisGeorge',
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 3.0,
          ),
          headline2: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            letterSpacing: 2.0,
          ),
          headline3: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
            letterSpacing: 2.0,
          ),
          headline4: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            letterSpacing: 2.0,
          ),
          headline5: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            letterSpacing: 2.0,
          ),
          headline1: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 10.0,
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            color: AppColors.black,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
