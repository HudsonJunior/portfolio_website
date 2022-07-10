import 'package:bloc/bloc.dart';

class FirebaseInitializerCubit extends Cubit<bool> {
  FirebaseInitializerCubit() : super(false);

  void initializeApp() async {
    emit(true);
  }
}
