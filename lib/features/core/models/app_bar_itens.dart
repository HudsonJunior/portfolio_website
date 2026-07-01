enum AppBarItens {
  home,
  experience,
  about,
  contact,
}

extension AppBarItensExt on AppBarItens {
  String get name {
    switch (this) {
      case AppBarItens.home:
        return 'Home';
      case AppBarItens.experience:
        return 'Experience';
      case AppBarItens.about:
        return 'About';
      case AppBarItens.contact:
        return 'Contact';
    }
  }
}
