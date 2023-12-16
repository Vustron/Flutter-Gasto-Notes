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
    apiKey: 'AIzaSyA0JqZN9QmvctnrPIG1dj5AGfjDi-2AFvY',
    appId: '1:517153295221:web:f7a9c0fda035cd9698e13c',
    messagingSenderId: '517153295221',
    projectId: 'flutter-gasto-notes',
    authDomain: 'flutter-gasto-notes.firebaseapp.com',
    storageBucket: 'flutter-gasto-notes.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjEF64iT8U13yP-zufrahwFd4TAJpkJQA',
    appId: '1:517153295221:android:5db516e4c339d10198e13c',
    messagingSenderId: '517153295221',
    projectId: 'flutter-gasto-notes',
    storageBucket: 'flutter-gasto-notes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCtUXkcMAievZEJlSjXaiW14fXP8w3R158',
    appId: '1:517153295221:ios:d9b7e8ab9c7eb6ec98e13c',
    messagingSenderId: '517153295221',
    projectId: 'flutter-gasto-notes',
    storageBucket: 'flutter-gasto-notes.appspot.com',
    iosBundleId: 'com.vustron.gastoNotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCtUXkcMAievZEJlSjXaiW14fXP8w3R158',
    appId: '1:517153295221:ios:0002649e8875b3f798e13c',
    messagingSenderId: '517153295221',
    projectId: 'flutter-gasto-notes',
    storageBucket: 'flutter-gasto-notes.appspot.com',
    iosBundleId: 'com.vustron.gastoNotes.RunnerTests',
  );
}
