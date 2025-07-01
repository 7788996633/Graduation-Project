import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color success = Colors.green;
  static const Color danger = Colors.red;
  static const Color darkBlue = Color(0xFF0D47A1);
  static const Color softGray = Color(0xFFE0E0E6);
  static const Color scaffold = Color(0xFFF1F1F6);
  static const Color textGrey= Color(0xFF6B7280);
}

Map<String, Color> currentTheme = {
  'BackGorund': AppColors.scaffold,
  'AppBar': AppColors.darkBlue,
  'Border': AppColors.softGray,
  'AppBarTitle': AppColors.white,
  'AppBarIcons': AppColors.white,
  'HomeCards': AppColors.softGray,
  'HomeCardsIcons': AppColors.darkBlue,
  'HomeCardsText': AppColors.darkBlue,
  'BoldText': AppColors.black,
  'NormalText': AppColors.black,
  'Icons': AppColors.black,
};

Map<String, Color> lightTheme = {
  'BackGorund': AppColors.scaffold,
  'AppBar': AppColors.darkBlue,
  'Border': AppColors.softGray,
  'AppBarTitle': AppColors.white,
  'AppBarIcons': AppColors.white,
  'HomeCards': AppColors.softGray,
  'HomeCardsIcons': AppColors.darkBlue,
  'HomeCardsText': AppColors.darkBlue,
  'BoldText': AppColors.black,
  'NormalText': AppColors.black,
  'Icons': AppColors.black,
};

Map<String, Color> darkTheme = {
  'BackGorund': AppColors.black,
  'AppBar': AppColors.black,
  'Border': AppColors.softGray,
  'AppBarTitle': AppColors.white,
  'AppBarIcons': AppColors.white,
  'HomeCards': AppColors.softGray,
  'HomeCardsIcons': AppColors.white,
  'HomeCardsText': AppColors.white,
  'BoldText': AppColors.white,
  'NormalText': AppColors.white,
  'Icons': AppColors.white,
};
bool isLight = true;

Map<String, Color> getCurrentTheme() {
  return isLight ? currentTheme : darkTheme;
}
