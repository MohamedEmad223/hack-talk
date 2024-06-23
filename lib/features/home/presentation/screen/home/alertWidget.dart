import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_talk/core/helpers/end_points.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/widgets/text_widgets.dart';
import 'package:hack_talk/features/setting/logic/cubit/settings_cubit.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const TextWidget(
        "Are you sure you want to exit HackTalk",
        maxLines: 9,
        textAlign: TextAlign.center,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: AppColors.mainColor,
              ),
            ),
          ),
          child: const Text(
            '       Cancel       ',
            style: TextStyle(color: AppColors.mainColor),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainColor,
          ),
          onPressed: () {
            BlocProvider.of<SettingsCubit>(context).logout(EndPoints.logout);
          },
          child: const Text(
            "     logout     ",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      contentPadding:
          const EdgeInsets.only(bottom: 33, left: 22, right: 22, top: 66),
      backgroundColor: Colors.white,
      shadowColor: AppColors.mainColor,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(38)),
    );
  }
}
