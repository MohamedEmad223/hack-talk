import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hack_talk/core/theming/app_colors.dart';

class TextStyles {
  static TextStyle font24mainBlueColor = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    color: AppColors.mainColor,
  );

  static TextStyle cairo12MediumTFFContentColor = TextStyle(
    color: AppColors.mainColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle cairo16BoldWhite = TextStyle(
    color: Colors.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle cairo11MediumTFFErrorColor = TextStyle(
    color: AppColors.tFFErrorColor,
    fontFamily: 'Roboto',
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
  );
static TextStyle hintStyle = TextStyle(
    color: AppColors.grey,
    fontFamily: 'Roboto',
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font11black = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
    color: AppColors.black,
  );

  static TextStyle font12black = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
    color: AppColors.doNotHaveAccount,
  );

  static TextStyle font16black = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
    color: AppColors.black,
  );

  static TextStyle font20mainBllueColor = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    color: AppColors.mainColor,
  );
}
