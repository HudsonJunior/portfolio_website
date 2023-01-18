enum MainlySkills {
  flutter,
  dart,
  mobile,
  android,
  ios,
  javascript,
  react,
  reactNative,
  node,
  typescript,
  communication,
  learningCurve,
  proativity,
  responsible,
}

extension MainlySkillsExt on MainlySkills {
  String get name {
    switch (this) {
      case MainlySkills.flutter:
        return "flutter - 4 years";
      case MainlySkills.dart:
        return "dart - 4 years";
      case MainlySkills.mobile:
        return "mobile - 4 years";
      case MainlySkills.android:
        return "android - 1 year";

      case MainlySkills.ios:
        return "ios - 1 year";

      case MainlySkills.javascript:
        return "javascript - 1 year";

      case MainlySkills.react:
        return "react - 1 year";

      case MainlySkills.reactNative:
        return "react native - 1 year";

      case MainlySkills.node:
        return "nodeJs - 1 year";

      case MainlySkills.typescript:
        return "typescript - 1 year";

      case MainlySkills.communication:
        return "communication";

      case MainlySkills.learningCurve:
        return "fast learning";

      case MainlySkills.proativity:
        return "proactive";

      case MainlySkills.responsible:
        return "responsible";
    }
  }
}
