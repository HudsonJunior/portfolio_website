enum AppBarItens {
  home,
  works,
  about,
  contact,
}

extension AppBarItensExt on AppBarItens {
  String get name {
    switch (this) {
      case AppBarItens.home:
        return "home";
      case AppBarItens.about:
        return "about";
      case AppBarItens.works:
        return "works";
      case AppBarItens.contact:
        return "contact";
    }
  }
}
