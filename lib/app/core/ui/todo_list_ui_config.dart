import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFAFBFE),
    textTheme: GoogleFonts.mandaliTextTheme(),
    primaryColor: Color(0xff5C77CE),
    primaryColorLight: Color(0xffABC8F7),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xff5C77CE),
      foregroundColor: Colors.white),
    ),
  );
}
