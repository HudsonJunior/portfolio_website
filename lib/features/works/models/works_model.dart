import 'package:portfolio_website/features/works/models/used_techs_model.dart';

enum WorksEnum { localDea, zombiepo, portfolio, legiaoBebidas, painter }

extension WorksEnumExt on WorksEnum {
  String get title {
    switch (this) {
      case WorksEnum.localDea:
        return "LocalDEA";
      case WorksEnum.zombiepo:
        return "ZOM-BIE-PÔ";
      case WorksEnum.portfolio:
        return "This portfolio!";
      case WorksEnum.legiaoBebidas:
        return "Liquor store";
      case WorksEnum.painter:
        return "Painter app";
    }
  }

  String get description {
    switch (this) {
      case WorksEnum.localDea:
        return "An application to find the shortest route to a healthcare service (hospitals, ambulances, AEDs).";
      case WorksEnum.zombiepo:
        return "A zombie-themed Jo-Ken-Pô.";
      case WorksEnum.portfolio:
        return "This portfolio that was entirely built with Flutter.";
      case WorksEnum.legiaoBebidas:
        return "A liquor store app that helps a small customer in my town get their digital menu.";
      case WorksEnum.painter:
        return "A simple app to draw. Created with animations and canvas.";
    }
  }

  String get icon {
    switch (this) {
      case WorksEnum.localDea:
        return "assets/localdea/icon.png";
      case WorksEnum.zombiepo:
        return "assets/zombiepo/icon.png";
      case WorksEnum.portfolio:
        return "assets/profile.jpeg";
      case WorksEnum.legiaoBebidas:
        return "assets/legiaobebidas/legiao.png";
      case WorksEnum.painter:
        return "assets/painter/color-palette.png";
    }
  }

  String get appImagesFormat {
    switch (this) {
      case WorksEnum.localDea:
        return "jpg";
      case WorksEnum.zombiepo:
        return "png";
      case WorksEnum.portfolio:
        return "";
      case WorksEnum.legiaoBebidas:
        return "jpeg";
      case WorksEnum.painter:
        return "png";
    }
  }

  int get appImagesLength {
    switch (this) {
      case WorksEnum.localDea:
        return 5;
      case WorksEnum.zombiepo:
        return 2;
      case WorksEnum.portfolio:
        return 0;
      case WorksEnum.legiaoBebidas:
        return 4;
      case WorksEnum.painter:
        return 4;
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
      case WorksEnum.portfolio:
        return [
          UsedTechsEnum.animations,
          UsedTechsEnum.bloc,
          UsedTechsEnum.cleanArch,
          UsedTechsEnum.cleanCode,
          UsedTechsEnum.firebase,
          UsedTechsEnum.responsiveness,
        ];
      case WorksEnum.legiaoBebidas:
        return [
          UsedTechsEnum.animations,
          UsedTechsEnum.bloc,
          UsedTechsEnum.cleanArch,
          UsedTechsEnum.cleanCode,
        ];
      case WorksEnum.painter:
        return [
          UsedTechsEnum.animations,
          UsedTechsEnum.canvas,
          UsedTechsEnum.bloc,
          UsedTechsEnum.cleanCode,
        ];
    }
  }

  String? get playstoreId {
    switch (this) {
      case WorksEnum.localDea:
        return null;
      case WorksEnum.zombiepo:
        return "com.hudson.jokenpo_game";
      case WorksEnum.portfolio:
        return null;
      case WorksEnum.legiaoBebidas:
        return null;
      default:
        return null;
    }
  }

  String? get githubUrl {
    switch (this) {
      case WorksEnum.localDea:
        return 'https://github.com/HudsonJunior/local_dea_app';
      case WorksEnum.zombiepo:
        return null;
      case WorksEnum.portfolio:
        return 'https://github.com/HudsonJunior/portfolio_website';
      case WorksEnum.legiaoBebidas:
        return 'https://github.com/HudsonJunior/legiao_bebidas_app';
      case WorksEnum.painter:
        return "https://github.com/HudsonJunior/painter_app";
    }
  }
}
