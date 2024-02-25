import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      textTheme:GoogleFonts.latoTextTheme(),
    colorScheme: ColorScheme(brightness: Brightness.light,
          primary: const Color(0xFFEB0029),
        onPrimary: Colors.black,
        secondary: const Color(0xFFFAFFD8),

        onSecondary: Colors.black, error: Colors.red , onError: Colors.white, background: Colors.white, onBackground: Colors.black, surface: Colors.grey.shade200, onSurface: Colors.black)
  );
  static ThemeData darkTheme = ThemeData.dark();
}
