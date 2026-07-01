import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const background = Color(0xFF0B0C10);
  static const surface = Color(0xFF14151C);
  static const surfaceAlt = Color(0xFF0D0E14);

  // Accent
  static const accent = Color(0xFF8B5CF6);
  static const accentBlue = Color(0xFF6366F1);
  static const accentLight = Color(0xFFA5B4FC);
  static const accentPurpleLight = Color(0xFFC4B5FD);

  // Semantic
  static const green = Color(0xFF34D399);
  static const yellow = Color(0xFFFBBF24);
  static const red = Color(0xFFFB7185);

  // Text
  static const text = Color(0xFFEDEEF2);
  static const textMuted = Color(0x99EDEEF2); // ~60% opacity
  static const textDim = Color(0x73EDEEF2); // ~45% opacity
  static const textFaint = Color(0x66EDEEF2); // ~40% opacity

  // Borders
  static const border = Color(0x14FFFFFF); // ~8% white
  static const borderMid = Color(0x29FFFFFF); // ~16% white

  // Legacy aliases kept so untouched files don't break
  static Color get backgroundColor => background;
  static Color get black => surface;
  static Color get smokeWhite => background;
}
