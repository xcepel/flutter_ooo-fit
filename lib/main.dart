import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ooo_fit/ioc/ioc_container.dart';
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
      theme: ThemeData(textTheme: GoogleFonts.openSansTextTheme()),
      home: OutfitsListPage(),
    );
  }
}
