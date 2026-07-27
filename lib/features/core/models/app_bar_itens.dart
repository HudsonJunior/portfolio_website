enum AppBarItens {
  home,
  talks,
  writing,
  experiments,
  experience,
  about,
  contact,
}

extension AppBarItensExt on AppBarItens {
  String get name {
    switch (this) {
      case AppBarItens.home:
        return 'Home';
      case AppBarItens.talks:
        return 'Talks';
      case AppBarItens.writing:
        return 'Writing';
      case AppBarItens.experiments:
        return 'Experiments';
      case AppBarItens.experience:
        return 'Experience';
      case AppBarItens.about:
        return 'About';
      case AppBarItens.contact:
        return 'Contact';
    }
  }
}
