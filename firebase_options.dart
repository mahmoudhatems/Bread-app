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
        return macos;
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
    apiKey: 'AIzaSyDDABfOzygwLA-xgSGAv9cldsgQaigYumo',
    appId: '1:151543705562:web:7c6bf5563dd38fe9955ae3',
    messagingSenderId: '151543705562',
    projectId: 'bread-app-5ca08',
    authDomain: 'bread-app-5ca08.firebaseapp.com',
    storageBucket: 'bread-app-5ca08.appspot.com',
    measurementId: 'G-2T4KLM7NDV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjMUq_fpGZEeTu8MpOEGSWD-D_EDrakUs',
    appId: '1:151543705562:android:35e13a041ec60f4a955ae3',
    messagingSenderId: '151543705562',
    projectId: 'bread-app-5ca08',
    storageBucket: 'bread-app-5ca08.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAl_jse1fsrLj1i7ET4Nc0Rf-oJLePfrqA',
    appId: '1:151543705562:ios:8c2d9fa131107e7e955ae3',
    messagingSenderId: '151543705562',
    projectId: 'bread-app-5ca08',
    storageBucket: 'bread-app-5ca08.appspot.com',
    iosBundleId: 'com.example.breadapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAl_jse1fsrLj1i7ET4Nc0Rf-oJLePfrqA',
    appId: '1:151543705562:ios:a778067808b390c4955ae3',
    messagingSenderId: '151543705562',
    projectId: 'bread-app-5ca08',
    storageBucket: 'bread-app-5ca08.appspot.com',
    iosBundleId: 'com.example.breadapp.RunnerTests',
  );
}
