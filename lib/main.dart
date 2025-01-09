import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ooo_fit/ioc/ioc_container.dart';
import 'package:ooo_fit/ooo_fit_theme.dart';
import 'package:ooo_fit/page/outfits_list_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  IocContainer.setup();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OOO-FIT",
      theme: oooFitTheme(),
      home: OutfitsListPage(),
    );
  }
}
