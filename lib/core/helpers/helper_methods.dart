import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/theming/assets.dart';
import 'package:hack_talk/core/theming/text_style.dart';

class HelperMethods {
  HelperMethods._();
  static void showCustomSnackBarSuccess(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyles.cairo16BoldWhite,
        ),
        backgroundColor: AppColors.mainColor,
        duration: const Duration(seconds: 3),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        elevation: 4,
      ),
    );
  }

  static void showCustomSnackBarError(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyles.cairo16BoldWhite,
        ),
        backgroundColor: AppColors.tFFErrorColor,
        duration: const Duration(seconds: 3),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        elevation: 4,
      ),
    );
  }

  static Future<Widget?> showLoadingAlertDialog(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: AbsorbPointer(
          absorbing: true,
          child: AlertDialog.adaptive(
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.mainColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
              height: 200.h,
              width: 100.w,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // static void afterLogin(
  //   BuildContext context,
  //   AuthCubit authCubit,
  //   LoginModel value,
  // ) {
  //   CacheHelper cacheHelper = CacheHelper();
  //   Navigator.pop(context);
  //   cacheHelper.saveData(key: 'email', value: value.data!['user']['email']);
  //   Navigator.pop(context);
  //   cacheHelper.saveData(key: 'name', value: value.data!['user']['name']);
  //   authCubit.rememberMe
  //       ? cacheHelper.saveData(key: AppConstants.rememberMeToken, value: true)
  //       : cacheHelper.removeData(key: AppConstants.rememberMeToken);
  //   authCubit.rememberMe
  //       ? Navigator.pushNamedAndRemoveUntil(
  //           context,
  //           Routes.home,
  //           (route) => false,
  //         )
  //       : null;
  // }

  void svgPrecacheImage() {
    const cacheSvgImages = [
      Assets.alert,
      Assets.arcticonsNcPasswords,
      Assets.audio,
      Assets.audioGallery,
      Assets.congratulation,
      Assets.contactUs,
      Assets.downImage,
      Assets.download,
      Assets.ellipse,
      Assets.feature1,
      Assets.feature2,
      Assets.feature3,
      Assets.feature4,
      Assets.fluentPerson24Regular,
      Assets.hacktalk,
      Assets.home,
      Assets.iconamoonArrowRight2Bold,
      Assets.login,
      Assets.logoSvg,
      Assets.mdiAboutCircleOutline,
      Assets.onBoarding1,
      Assets.onBoarding2,
      Assets.onBoarding3,
      Assets.onBoarding4,
      Assets.profile,
      Assets.question,
      Assets.record,
      Assets.recordPause,
      Assets.recordVideo,
      Assets.reset,
      Assets.signUp,
      Assets.solarStarFallBroken,
      Assets.startAudioRecord,
      Assets.startDownloadImageAudio,
      Assets.startRecording,
      Assets.startRecordingImageAudio,
      Assets.stopIconAudioRecord,
      Assets.text2Logo,
      Assets.textLogo,
      Assets.upImage,
      Assets.uploadVideo,
      Assets.uploadVideoImage,
      Assets.verification,
      Assets.video,
      Assets.videoGallery,
    ];

    for (String element in cacheSvgImages) {
      var loader = SvgAssetLoader(element);
      svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }
}
