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
    apiKey: 'AIzaSyCiNfhasP0zHIIwxwZYT5Yj58Ws9c00M_o',
    appId: '1:102686854528:web:f9038b3d289742a6824565',
    messagingSenderId: '102686854528',
    projectId: 'productive-muslim-6fdaa',
    authDomain: 'productive-muslim-6fdaa.firebaseapp.com',
    databaseURL: 'https://productive-muslim-6fdaa-default-rtdb.firebaseio.com',
    storageBucket: 'productive-muslim-6fdaa.appspot.com',
    measurementId: 'G-C5Q3GJK50G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATmbD2UnTfh97073pDi6poZ1KjPTh-pM8',
    appId: '1:102686854528:android:47f89a706d33ec93824565',
    messagingSenderId: '102686854528',
    projectId: 'productive-muslim-6fdaa',
    databaseURL: 'https://productive-muslim-6fdaa-default-rtdb.firebaseio.com',
    storageBucket: 'productive-muslim-6fdaa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIIK-MNj5Wb4DxXrQ6ZzSbE9F6TWem9H4',
    appId: '1:102686854528:ios:cffa3d30858ae922824565',
    messagingSenderId: '102686854528',
    projectId: 'productive-muslim-6fdaa',
    databaseURL: 'https://productive-muslim-6fdaa-default-rtdb.firebaseio.com',
    storageBucket: 'productive-muslim-6fdaa.appspot.com',
    androidClientId: '102686854528-cu2htpobt7ticn3d3jt697fncipt5daj.apps.googleusercontent.com',
    iosClientId: '102686854528-qbht77nsm4m45aj38kjvnhp4sflft6nf.apps.googleusercontent.com',
    iosBundleId: 'com.muslim.productive',
  );
}