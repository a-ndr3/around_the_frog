import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AppColors.dart';

class AppTextStyles {
  static TextStyle homePageDescriptionText = GoogleFonts.exo(
    fontSize: 27,
    fontWeight: FontWeight.w200,
    color: AppColors.statistictDescriptionColor,
  );

  static TextStyle homePageTitleText = GoogleFonts.exo(
    fontSize: 64,
    fontWeight: FontWeight.w600,
    color: AppColors.statistictDescriptionColor,
  );

  static TextStyle statisticsDescriptionText = GoogleFonts.exo(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.statisticsColor,
  );

  static TextStyle statisticsTitleText = GoogleFonts.exo(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.appBackgroundColor,
  );
}
