import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';

class ControlPageCubit extends Cubit<AppBarItens> {
  ControlPageCubit() : super(AppBarItens.home);

  void scrollTo(AppBarItens item) {
    emit(item);
  }
}
