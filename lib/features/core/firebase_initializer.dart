import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio_website/firebase_options.dart';

class FirebaseInitializerCubit extends Cubit<bool> {
  FirebaseInitializerCubit() : super(false);

  void initializeApp() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform)
      ..setAutomaticDataCollectionEnabled(true)
      ..setAutomaticResourceManagementEnabled(true);
    await FirebaseAnalytics.instance.setUserId();

    emit(true);
  }
}
