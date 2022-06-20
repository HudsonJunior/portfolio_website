enum MainlySkills {
  flutter,
  dart,
  mobile,
  solid,
  cleanArch,
  cleanCode,
  mvvm,
  mvc,
  designPatterns,
  flavors,
  tests,
  tdd,
  animations,
  isolates,
  canvas,
  slivers,
  bloc,
  featureToggle,
  microFront
}

extension MainlySkillsEct on MainlySkills {
  String get name {
    switch (this) {
      case MainlySkills.flutter:
        return "flutter";
      case MainlySkills.dart:
        return "dart";
      case MainlySkills.mobile:
        return "mobile";
      case MainlySkills.solid:
        return "s.o.l.i.d";
      case MainlySkills.cleanArch:
        return "clean architecture";
      case MainlySkills.cleanCode:
        return "clean code";
      case MainlySkills.mvvm:
        return "mvvm";
      case MainlySkills.mvc:
        return "mvc";
      case MainlySkills.designPatterns:
        return "design patterns";
      case MainlySkills.flavors:
        return "flavors";
      case MainlySkills.tests:
        return "tests";
      case MainlySkills.tdd:
        return "tdd";
      case MainlySkills.bloc:
        return "bloc";
      case MainlySkills.animations:
        return "animations";
      case MainlySkills.isolates:
        return "isolates";
      case MainlySkills.canvas:
        return "canvas";
      case MainlySkills.featureToggle:
        return "feature toggle";
      case MainlySkills.microFront:
        return "micro frontend";
      case MainlySkills.slivers:
        return "slivers";
    }
  }
}
