import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hack_talk/core/theming/app_colors.dart';

class ButtonSec extends StatelessWidget {
  const ButtonSec(
      {super.key,
      required this.text,
      required this.color,
      required this.onPressed});
  final String text;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 35.h,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            side: const BorderSide(color: AppColors.mainColor),
            backgroundColor: Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(color: color),
          )),
    );
  }
}
