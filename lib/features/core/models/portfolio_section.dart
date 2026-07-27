enum PortfolioSection {
  home,
  talks,
  writing,
  experiments,
  experience,
  about,
  contact,
}

extension PortfolioSectionX on PortfolioSection {
  String get label {
    switch (this) {
      case PortfolioSection.home:
        return 'Home';
      case PortfolioSection.talks:
        return 'Talks';
      case PortfolioSection.writing:
        return 'Writing';
      case PortfolioSection.experiments:
        return 'Experiments';
      case PortfolioSection.experience:
        return 'Experience';
      case PortfolioSection.about:
        return 'About';
      case PortfolioSection.contact:
        return 'Contact';
    }
  }

  String get slug => name;
}

PortfolioSection? portfolioSectionFromSlug(String slug) {
  for (final section in PortfolioSection.values) {
    if (section.slug == slug) return section;
  }
  return null;
}
