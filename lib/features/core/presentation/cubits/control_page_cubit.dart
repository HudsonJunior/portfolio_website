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
      final bool isAtHome = position >= 0 && position < currentHeight * 0.7;

      if (state != AppBarItens.home && isAtHome) {
        return emit(AppBarItens.home);
      }

      final bool isAtAbout =
          position >= currentHeight * 1.7 && position < currentHeight * 2.7;

      if (state != AppBarItens.about && isAtAbout) {
        return emit(AppBarItens.about);
      }

      final bool isAtWorks =
          position >= currentHeight * 0.7 && position < currentHeight * 1.7;

      if (state != AppBarItens.works && isAtWorks) {
        return emit(AppBarItens.works);
      }

      final bool isAtContact =
          position >= currentHeight * 2.7 && position < currentHeight * 3.7;

      if (state != AppBarItens.contact && isAtContact) {
        return emit(AppBarItens.contact);
      }
    }
  }
}
