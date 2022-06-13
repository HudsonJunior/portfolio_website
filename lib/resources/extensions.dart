import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  TextTheme get themeData => Theme.of(this).textTheme;
}
