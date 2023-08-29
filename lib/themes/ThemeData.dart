
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData{
  static const Color light=Color(0xff5D9CEC);
  static ThemeData lightmode=ThemeData(
    scaffoldBackgroundColor: Color(0xffDFECDB),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      backgroundColor: light,
          toolbarHeight: 140,
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
        selectedItemColor:light

  ),
      textTheme: TextTheme(
      bodySmall: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 15,
    fontWeight: FontWeight.w500,
  ),
      bodyMedium: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
      bodyLarge: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 20,
    fontWeight: FontWeight.bold,
  )
  )
  );
  static const Color dark=Color(0xff141922);
  static ThemeData darkmode=ThemeData(
      scaffoldBackgroundColor: Color(0xff060E1E),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: light,
        toolbarHeight: 140,
      ),
      textTheme: TextTheme(
          bodySmall: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(

          selectedItemColor:light,
          unselectedItemColor: Colors.white
      )
  );
}
