import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hack_talk/core/errors/validation/error_message.dart';
import 'package:hack_talk/core/errors/validation/validation_error_message.dart';
import 'package:hack_talk/core/helpers/app_constants.dart';
import 'package:hack_talk/core/helpers/end_points.dart';
import 'package:hack_talk/core/helpers/extension.dart';
import 'package:hack_talk/core/helpers/helper_methods.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/widgets/button_sec.dart';
import 'package:hack_talk/core/widgets/button_widgets.dart';
import 'package:hack_talk/core/widgets/custom_text_feild.dart';
import 'package:hack_talk/features/setting/logic/cubit/settings_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late SettingsCubit settingsCubit;
  @override
  void initState() {
    settingsCubit = BlocProvider.of<SettingsCubit>(context);

    super.initState();
  }

  @override
  void dispose() {
    settingsCubit.currentPasswored.dispose();
    settingsCubit.newPassword.dispose();
    settingsCubit.confirmPassword.dispose();
    settingsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          HelperMethods.showCustomSnackBarSuccess(
              context, state.changePasswordModel.message!);
        }
        if (state is ChangePasswordFailed) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error));
        }
        if (state is ChangePasswordLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            leading: const BackButton(
              color: AppColors.mainColor,
            ),
            title: SvgPicture.asset('hacktalk'.getSvgAsset),
          ),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormFeild(
                      controller: settingsCubit.currentPasswored,
                      hintText: 'Current Password',
                      kbType: TextInputType.visiblePassword,
                      lableText: 'Enter current Password',
                      validator: (value) {
                        return ValidationErrorTexts.confirmPasswordValidation(
                            value, settingsCubit.currentPasswored.text);
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormFeild(
                      controller: settingsCubit.newPassword,
                      hintText: 'New Password',
                      kbType: TextInputType.visiblePassword,
                      lableText: 'Enter Your New Password',
                      validator: (value) {
                        return ValidationErrorTexts.confirmPasswordValidation(
                            value, settingsCubit.currentPasswored.text);
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormFeild(
                      controller: settingsCubit.confirmPassword,
                      hintText: 'Confirm Password',
                      kbType: TextInputType.visiblePassword,
                      lableText: 'Confirm Your Password',
                      validator: (value) {
                        return ValidationErrorTexts.confirmPasswordValidation(
                            value, settingsCubit.currentPasswored.text);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ButtonWidget(
                      'update password',
                      color: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          settingsCubit.changePassword(
                              EndPoints.changePassword, {
                            'current_password': settingsCubit.currentPasswored.text,
                            'new_password': settingsCubit.newPassword.text,
                            'confirm_password': settingsCubit.confirmPassword.text
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    ButtonSec(
                      text: AppConstants.cancel,
                      color: AppColors.mainColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ))),
    );
  }
}
