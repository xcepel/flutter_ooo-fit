// theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ooo_fit/utils/constants.dart';

ThemeData oooFitTheme() {
  return ThemeData(
    textTheme: GoogleFonts.openSansTextTheme(),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(detailLightPurple), width: 1.0),
      ),
      // Underline when the field is focused
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.deepPurpleAccent.shade100, width: 1.5),
      ),
    ),
  );
}
