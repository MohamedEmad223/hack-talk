import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hack_talk/core/helpers/app_constants.dart';
import 'package:hack_talk/core/helpers/extension.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/theming/text_style.dart';
import 'package:hack_talk/core/widgets/button_widgets.dart';
import 'package:hack_talk/features/auth/presentation/screens/login_screen.dart';

class LoadScreen extends StatelessWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColors.mainColor),
        forceMaterialTransparency: true,
        title: SvgPicture.asset('hacktalk'.getSvgAsset),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 80.h),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset('assets/svgs/congratulation.svg'),
                SizedBox(height: 20.h),
                Text(
                  AppConstants.success,
                  style: TextStyles.font20mainBllueColor,
                ),
                SizedBox(height: 20.h),
                Text(AppConstants.loadingText,
                    textAlign: TextAlign.center,
                    style: TextStyles.font16black.copyWith(
                      color: AppColors.grey,
                    )),
                SizedBox(height: 40.h),
                ButtonWidget(
                  AppConstants.login,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
