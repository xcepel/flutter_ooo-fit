import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ooo_fit/ioc/ioc_container.dart';
import 'package:ooo_fit/ooo_fit_theme.dart';
import 'package:ooo_fit/service/util/last_worn_updater.dart';
import 'package:ooo_fit/widget/auth/auth_wrapper.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  IocContainer.setup();

  final LastWornUpdater updater = LastWornUpdater();
  updater.updateLastWorn();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OOO-FIT",
      theme: oooFitTheme(),
      home: AuthWrapper(),
    );
  }
}
