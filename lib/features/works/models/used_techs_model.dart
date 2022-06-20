enum UsedTechsEnum {
  firebase,
  googleAds,
  bloc,
  animations,
  maps,
  location,
  cleanArch,
  cleanCode,
  designPatterns,
}

extension UsedTechEnumExt on UsedTechsEnum {
  String get title {
    switch (this) {
      case UsedTechsEnum.firebase:
        return "firebase";
      case UsedTechsEnum.googleAds:
        return "google ads";
      case UsedTechsEnum.bloc:
        return "bloc";
      case UsedTechsEnum.animations:
        return "animations";
      case UsedTechsEnum.maps:
        return "maps";
      case UsedTechsEnum.location:
        return "location";
      case UsedTechsEnum.cleanArch:
        return "clean arch";
      case UsedTechsEnum.cleanCode:
        return "clean code";
      case UsedTechsEnum.designPatterns:
        return "design patterns";
    }
  }
}
