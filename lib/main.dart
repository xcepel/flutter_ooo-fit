import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> _firebaseApp =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Firebase')),
        body: FutureBuilder(
            future: _firebaseApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Firebase error');
              }

              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              return const Text('Firebase initialized');
            }),
      ),
    );
  }
}
