import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme{
  static ThemeData lightTheme =  ThemeData().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.kWhite),
    scaffoldBackgroundColor: AppColors.kWhite,
  );
  static ThemeData darkTheme =  ThemeData().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    brightness:Brightness.dark,
    scaffoldBackgroundColor: AppColors.kBlack,
  );
}