import 'package:bloc/bloc.dart';

class WorksCubit extends Cubit<bool> {
  WorksCubit() : super(false);

  void changeVisibility() {
    if (state) return;

    emit(true);
  }
}
