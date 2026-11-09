import 'package:flutter/material.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/core/app_colors.dart';

class AppTextStyles {
  static const landingHeadline = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 40,
    height: 48 / 40,
    letterSpacing: -0.8,
    color: AppColors.blackColor,
  );

  static const signUpButton = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w900,
    fontSize: 20,
    color: AppColors.blackColor,
  );

  static const termsLink = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 14,
    letterSpacing: -0.28,
    color: AppColors.primaryLime,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primaryLime,
  );

  static const homeGreeting = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 28,
    letterSpacing: -0.56,
    color: AppColors.blackColor,
  );

  static const homeSubtitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 15,
    color: AppColors.blackColor,
  );

  static const searchHint = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 13,
    color: AppColors.grayText,
  );

  static const sectionTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 20,
    color: AppColors.blackColor,
  );

  static const sectionAction = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 15,
    color: AppColors.grayText,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.grayText,
  );

  static const cardTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 13,
    letterSpacing: -0.26,
    color: AppColors.blackColor,
  );

  static const navLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 13,
    color: AppColors.blackColor,
  );

  static const screenTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 20,
    letterSpacing: -0.4,
    color: AppColors.blackColor,
  );

  static const trackTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 28,
    letterSpacing: -0.56,
    color: AppColors.blackColor,
  );

  static const trackArtist = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 16,
    letterSpacing: -0.32,
    color: AppColors.blackColor,
  );

  static const lyricsButton = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 18,
    color: AppColors.whiteColor,
  );

  static const episodeTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 14,
    height: 16 / 14,
    color: AppColors.darkGrayText,
  );

  static const episodeMeta = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 12,
    height: 16 / 12,
    color: AppColors.darkGrayText,
  );
}
