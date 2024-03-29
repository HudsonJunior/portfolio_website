// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC0Jdx2Ce80yNukMcXb0DcybQ5afUBn8UA',
    appId: '1:680782250631:web:935d93e7d3f9fbb4b9ee22',
    messagingSenderId: '680782250631',
    projectId: 'portfolio-website-9bb90',
    authDomain: 'portfolio-website-9bb90.firebaseapp.com',
    storageBucket: 'portfolio-website-9bb90.appspot.com',
    measurementId: 'G-3EETVJ4E6E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpeyR3iMNy8YjaxpXz9LHCX1ptuh4vTrc',
    appId: '1:680782250631:android:937bbe4100798a9fb9ee22',
    messagingSenderId: '680782250631',
    projectId: 'portfolio-website-9bb90',
    storageBucket: 'portfolio-website-9bb90.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFtSp_SvDlb0ACKZNR-PqR0jL2KPkYe7s',
    appId: '1:680782250631:ios:9fe8d39e40f1230ab9ee22',
    messagingSenderId: '680782250631',
    projectId: 'portfolio-website-9bb90',
    storageBucket: 'portfolio-website-9bb90.appspot.com',
    iosClientId: '680782250631-4eehltmolod4rbt21eebcivbauct1ud9.apps.googleusercontent.com',
    iosBundleId: 'com.example.portfolioWebsite',
  );
}
