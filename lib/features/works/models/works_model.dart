import 'package:portfolio_website/features/works/models/used_techs_model.dart';

enum WorksEnum { localDea, zombiepo, portfolio, legiaoBebidas }

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
    }
  }

  String get description {
    switch (this) {
      case WorksEnum.localDea:
        return "LocalDEA was an application that I developed as a final graduation project in computer science. Basically, the application locate the shortest route to a health service (hospitals, ambulances, AEDs).";
      case WorksEnum.zombiepo:
        return "ZOM-BIE-PÔ was the first application I developed with Flutter. The app is basically a zombie-themed Jo-Ken-Pô. I worked with some GoogleAds ads and some animations. It's quite simple, but for the first project, I think it's great :D";
      case WorksEnum.portfolio:
        return "Of course, I couldn't let mention this portfolio you are accessing right now, which was built entirely with Flutter web, using all the power that Flutter gives us to build responsive, beautiful and performant websites :)";
      case WorksEnum.legiaoBebidas:
        return "A liquor store app that helps a small customer in my town get their menu digital. App users can view and add products to a cart, when they finish adding they can send an automatic message to the store owner, with all products, total price and delivery location, helping the owner to know exactly what the customer want.";
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
    }
  }
}
