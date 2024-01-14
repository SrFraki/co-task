import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class ATheme{
  static get darkMode{
    return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }

  static get themeLight{
    return ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: const Color.fromARGB(255, 38, 38, 38),
      // colorSchemeSeed: const Color.fromARGB(255, 237, 214, 13),
      // colorSchemeSeed: Colors.deepPurple,
      fontFamily: GoogleFonts.montserrat().fontFamily,

      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.montserrat().copyWith(color: Colors.black),
      ),

      cardColor: Colors.grey.shade100,
    );
  }

  static get themeDark{
    return ThemeData(
      brightness: Brightness.dark,

      scaffoldBackgroundColor: const Color.fromARGB(255, 36, 36, 36),
      
      
      fontFamily: GoogleFonts.montserrat().fontFamily,


      
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.montserrat().copyWith(color: Colors.white.withOpacity(0.9)),
      ),



      cardColor: const Color.fromARGB(255, 41, 41, 41),
      
    );
  }
}
