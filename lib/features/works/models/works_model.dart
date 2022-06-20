import 'package:portfolio_website/features/works/models/used_techs_model.dart';

enum WorksEnum { localDea, zombiepo }

extension WorksEnumExt on WorksEnum {
  String get title {
    switch (this) {
      case WorksEnum.localDea:
        return "LocalDEA";
      case WorksEnum.zombiepo:
        return "ZOM-BIE-PÔ";
    }
  }

  String get description {
    switch (this) {
      case WorksEnum.localDea:
        return "LocalDEA was an application that I developed as a final graduation project in computer science. Basically, the application locate the shortest route to a health service (hospitals, ambulances, AEDs). In addition, the app has the following features: frequently asked questions about cardiac arrest, a CPR guide, emailing, and emergency calls. The application was developed following GoF design patterns, architecture following Clean Architecture and some implicit animations were used to make it more beautiful.";
      case WorksEnum.zombiepo:
        return "ZOM-BIE-PÔ was the first application I developed with Flutter. The app is basically a zombie-themed Jo-Ken-Pô. I worked with some GoogleAds ads and some animations. It's quite simple, but for the first project, I think it's great :D";
    }
  }

  String get icon {
    switch (this) {
      case WorksEnum.localDea:
        return "assets/localdea/icon.png";
      case WorksEnum.zombiepo:
        return "assets/zombiepo/icon.png";
    }
  }

  String get appImagesFormat {
    switch (this) {
      case WorksEnum.localDea:
        return "jpg";
      case WorksEnum.zombiepo:
        return "png";
    }
  }

  int get appImagesLength {
    switch (this) {
      case WorksEnum.localDea:
        return 12;
      case WorksEnum.zombiepo:
        return 2;
    }
  }

  List<UsedTechsEnum> get usedTechs {
    switch (this) {
      case WorksEnum.localDea:
        return [
          UsedTechsEnum.animations,
          UsedTechsEnum.bloc,
          UsedTechsEnum.location,
          UsedTechsEnum.maps,
          UsedTechsEnum.cleanArch,
          UsedTechsEnum.cleanCode,
          UsedTechsEnum.designPatterns,
        ];
      case WorksEnum.zombiepo:
        return [
          UsedTechsEnum.googleAds,
          UsedTechsEnum.animations,
        ];
    }
  }

  String? get playstoreId {
    switch (this) {
      case WorksEnum.localDea:
        return null;
      case WorksEnum.zombiepo:
        return "com.hudson.jokenpo_game";
    }
  }
}
