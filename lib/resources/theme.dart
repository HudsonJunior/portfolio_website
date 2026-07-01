import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/resources/colors.dart';

class AppTextStyles {
  // Space Grotesk — headings
  static TextStyle spaceGrotesk({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.text,
    double letterSpacingEm = -0.02,
    double? height,
  }) =>
      GoogleFonts.spaceGrotesk(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacingEm * fontSize,
        height: height,
      );

  // Manrope — body
  static TextStyle manrope({
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.text,
    double? height,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.manrope(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  // JetBrains Mono — labels / code
  static TextStyle mono({
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textDim,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );
}

class PortfolioTheme {
  static ThemeData get themeData => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.surface,
          primary: AppColors.accent,
          secondary: AppColors.accentBlue,
          onSurface: AppColors.text,
        ),
        textTheme: TextTheme(
          // H1 — hero headline
          displayLarge: AppTextStyles.spaceGrotesk(
            fontSize: 48,
            letterSpacingEm: -0.03,
            height: 1.03,
          ),
          // H2 — section headings
          displayMedium: AppTextStyles.spaceGrotesk(
            fontSize: 32,
            letterSpacingEm: -0.025,
          ),
          // H3 — card titles
          displaySmall: AppTextStyles.spaceGrotesk(
            fontSize: 20,
            letterSpacingEm: -0.02,
          ),
          // Body large
          bodyLarge: AppTextStyles.manrope(
            fontSize: 16,
            color: AppColors.textMuted,
            height: 1.68,
          ),
          // Body medium
          bodyMedium: AppTextStyles.manrope(
            fontSize: 14,
            color: AppColors.textMuted,
            height: 1.65,
          ),
          // Mono label
          labelSmall: AppTextStyles.mono(
            fontSize: 12,
            color: AppColors.accentLight,
            letterSpacing: 0.06 * 12,
          ),
        ),
      );
}
