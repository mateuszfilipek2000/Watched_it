import 'package:flutter/material.dart';

//TODO ADD THEMES
class Themes {
  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Color(0xff141417),
    scaffoldBackgroundColor: Color(0xff141417),
    colorScheme: ColorScheme.dark().copyWith(
      surface: Color(0xff1d1d21),
    ),
  );

  static ThemeData light = ThemeData.light().copyWith();
}
