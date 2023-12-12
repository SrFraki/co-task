import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewVersionAviableScreen extends StatelessWidget {
   
  const NewVersionAviableScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: Text(
          'New version avaiable',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.white70
          ),
        ),
      ),
    );
  }
}