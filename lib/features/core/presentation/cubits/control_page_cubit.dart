import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/models/portfolio_section.dart';

class ControlPageCubit extends Cubit<PortfolioSection> {
  ControlPageCubit() : super(PortfolioSection.home);

  /// Updates the section highlighted by the landing-page navigation.
  void setSection(PortfolioSection section) {
    if (state != section) emit(section);
  }
}
