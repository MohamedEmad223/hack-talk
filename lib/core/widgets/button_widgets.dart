import 'package:flutter/material.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/widgets/text_widgets.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(this.text, {super.key, this.onPressed, this.color});
  final String text;
  final Color? color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18))),
        child: TextWidget(text,color: color),
      ),
    );
  }
}
