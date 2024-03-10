import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class ATheme{
  static bool get darkMode{
    return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }

  static get themeLight{
    return ThemeData(
      brightness: Brightness.light,
      // colorSchemeSeed: Color.fromARGB(255, 107, 99, 99),
      // colorSchemeSeed: const Color.fromARGB(255, 237, 214, 13),
      // colorSchemeSeed: Colors.deepPurple,
      fontFamily: GoogleFonts.montserrat().fontFamily,

      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.montserrat().copyWith(color: Colors.black),
      ),

      cardTheme: CardTheme(surfaceTintColor: Colors.grey.shade400)
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



      cardTheme: const CardTheme(surfaceTintColor: Color.fromARGB(255, 31, 31, 31))
    );
  }


  static Color get green => darkMode ? const Color(0xFF738C74) : Colors.green.shade300;
  static Color get cardColor => darkMode ? const Color(0xFF2B2B2B) : Colors.grey.shade200;
  static Color get ownTaskCardColor => darkMode ? Colors.grey.shade800 : Colors.white;
  static List<BoxShadow> get shadow => const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1, offset: Offset(3,3))];
}
