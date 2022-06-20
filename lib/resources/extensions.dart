import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

extension ContextExt on BuildContext {
  TextTheme get themeData => Theme.of(this).textTheme;
}

extension VisibilityExt on VisibilityInfo {
  bool isVisible([double portion = 98]) => (visibleFraction * 100) < portion;
}
