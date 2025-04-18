// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyB8IAw-x1gqy7m23bKr61ZDq0glLlFfXoQ',
    appId: '1:412620653223:web:444e26ce54683314c91182',
    messagingSenderId: '412620653223',
    projectId: 'ooo-fit',
    authDomain: 'ooo-fit.firebaseapp.com',
    databaseURL: 'https://ooo-fit-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'ooo-fit.firebasestorage.app',
    measurementId: 'G-5XZFM5QM0D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDk37j0AaFvmfOu7glaLNVD1PQZnBkfjtE',
    appId: '1:412620653223:android:44297ad547f32c80c91182',
    messagingSenderId: '412620653223',
    projectId: 'ooo-fit',
    databaseURL: 'https://ooo-fit-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'ooo-fit.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC1s6fJPoW173vUIDRAgC9mlaX39LKSAug',
    appId: '1:412620653223:web:c54a7bb66c7894dcc91182',
    messagingSenderId: '412620653223',
    projectId: 'ooo-fit',
    authDomain: 'ooo-fit.firebaseapp.com',
    databaseURL: 'https://ooo-fit-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'ooo-fit.firebasestorage.app',
    measurementId: 'G-X6ESECLGW3',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVNPjFLCz7lX8_rulimo5DyXsHSaDoruc',
    appId: '1:412620653223:ios:da6d881bba814720c91182',
    messagingSenderId: '412620653223',
    projectId: 'ooo-fit',
    databaseURL: 'https://ooo-fit-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'ooo-fit.firebasestorage.app',
    iosBundleId: 'com.example.oooFit',
  );

}