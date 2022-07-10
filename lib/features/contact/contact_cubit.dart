import 'package:bloc/bloc.dart';

class ContactCubit extends Cubit<bool> {
  ContactCubit() : super(false);

  void changeVisibility() {
    if (state) return;

    emit(true);
  }
}
