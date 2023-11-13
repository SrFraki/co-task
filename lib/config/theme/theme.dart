import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ATheme{
  static get theme{
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: const Color.fromARGB(255, 237, 214, 13),

      fontFamily: GoogleFonts.montserrat().fontFamily

    );
  }
}

/**
 * 'strikemaster': {
  *  '50': '#f9f6f9',
  *  '100': '#f4eff3',
  *  '200': '#ebdfe8',
  *  '300': '#dbc6d5',
  *  '400': '#c3a3bb',
  *  '500': '#af85a3',
  *  '600': '#8d627e',
  *  '700': '#805670',
  *  '800': '#6b495e',
  *  '900': '#5b4051',
  *  '950': '#35222e',
  *},
*
 */