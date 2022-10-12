import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';

class ControlPageCubit extends Cubit<AppBarItens> {
  ControlPageCubit() : super(AppBarItens.home);

  bool _isAnimating = false;

  void scrollTo(AppBarItens item) {
    _isAnimating = true;
    emit(item);
  }

  void toggleAnimatingValue() {
    _isAnimating = false;
  }

  void updateBasedOnScrollPosition(double position, double currentHeight) {
    if (!_isAnimating) {
      final bool isAtHome = position >= 0 && position < currentHeight * 0.5;

      if (state != AppBarItens.home && isAtHome) {
        return emit(AppBarItens.home);
      }

      final bool isAtArticles =
          position >= currentHeight * 0.5 && position < currentHeight * 1.5;

      if (state != AppBarItens.articles && isAtArticles) {
        return emit(AppBarItens.articles);
      }

      final bool isAtWorks =
          position >= currentHeight * 1.5 && position < currentHeight * 2.5;

      if (state != AppBarItens.works && isAtWorks) {
        return emit(AppBarItens.works);
      }

      final bool isAtAbout =
          position >= currentHeight * 2.5 && position < currentHeight * 3.5;

      if (state != AppBarItens.about && isAtAbout) {
        return emit(AppBarItens.about);
      }

      final bool isAtContact =
          position >= currentHeight * 3.5 && position < currentHeight * 4.5;

      if (state != AppBarItens.contact && isAtContact) {
        return emit(AppBarItens.contact);
      }
    }
  }
}
