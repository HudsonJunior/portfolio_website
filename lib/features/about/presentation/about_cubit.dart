import 'package:bloc/bloc.dart';

class AboutCubit extends Cubit<bool> {
  AboutCubit() : super(false);

  void changeVisibility() {
    if (state) return;

    emit(true);
  }
}
