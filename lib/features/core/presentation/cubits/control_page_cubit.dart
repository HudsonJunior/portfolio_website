import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';

class ControlPageCubit extends Cubit<AppBarItens> {
  ControlPageCubit() : super(AppBarItens.home);

  static const _sections = [
    AppBarItens.home,
    AppBarItens.experience,
    AppBarItens.about,
    AppBarItens.contact,
  ];

  /// Called from the scroll listener with the index of the currently-visible
  /// section (determined by actual widget positions, not fixed multipliers).
  void setSection(int index) {
    if (index < 0 || index >= _sections.length) return;
    final item = _sections[index];
    if (state != item) emit(item);
  }
}
