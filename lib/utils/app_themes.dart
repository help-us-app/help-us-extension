import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      cardColor: HexColor("#1E1E1E"),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.primary,
        cursorColor: AppColors.primary,
      ),
      indicatorColor: AppColors.primary,
      scaffoldBackgroundColor: Colors.black,
      splashColor: Colors.transparent,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      fontFamily: GoogleFonts.dmSans().fontFamily,
      textTheme: const TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          headline5: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          headline1:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600)));
}
