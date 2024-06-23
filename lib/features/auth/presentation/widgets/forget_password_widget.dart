import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hack_talk/core/helpers/app_constants.dart';
import 'package:hack_talk/core/routes/routes.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/theming/text_style.dart';

class ForgetPasswordWidget extends StatefulWidget {
  const ForgetPasswordWidget({super.key});

  @override
  State<ForgetPasswordWidget> createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlutterSwitch(
          height: 20.0.h,
          width: 40.0.w,
          padding: 4.0.sp,
          toggleSize: 15.0,
          borderRadius: 10.0,
          activeColor: AppColors.mainColor,
          value: isSwitched,
          onToggle: (value) {
            setState(() {
              isSwitched = value;
            });
          },
        ),
        SizedBox(width: 5.w),
        Text(AppConstants.rememberMe, style: TextStyles.font11black),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context,
                Routes.forgetPassword,);
          },
          child: Text(
            AppConstants.forgotPassword,
            style: TextStyles.font11black,
          ),
        ),
      ],
    );
  }
}
