import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hack_talk/core/errors/validation/error_message.dart';
import 'package:hack_talk/core/errors/validation/validation_error_message.dart';
import 'package:hack_talk/core/helpers/app_constants.dart';
import 'package:hack_talk/core/helpers/auth_req.dart';
import 'package:hack_talk/core/helpers/extension.dart';
import 'package:hack_talk/core/helpers/helper_methods.dart';
import 'package:hack_talk/core/routes/routes.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/theming/text_style.dart';
import 'package:hack_talk/core/widgets/button_sec.dart';
import 'package:hack_talk/core/widgets/button_widgets.dart';
import 'package:hack_talk/core/widgets/custom_text_feild.dart';
import 'package:hack_talk/features/auth/data/models/reset_password_model.dart';
import 'package:hack_talk/features/auth/logic/cubit/forget_password_cubit.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({
    super.key,
  });

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late ForgetPasswordCubit forgetPasswordCubit;
  @override
  void initState() {
    forgetPasswordCubit = BlocProvider.of<ForgetPasswordCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    forgetPasswordCubit.passwordController.dispose();
    forgetPasswordCubit.confirmPasswordController.dispose();
    forgetPasswordCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResetPasswordModel resetPasswordModel = ResetPasswordModel();
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordFailed) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error!));
        }
        if (state is ResetPasswordSuccess) {
          Navigator.pushNamed(
            context,
            Routes.load,
          );
          HelperMethods.showCustomSnackBarSuccess(
              context, 'password reset successfully');
        }
      },
      child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: SvgPicture.asset('hacktalk'.getSvgAsset),
          ),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SingleChildScrollView(
              child: Form(
                key: forgetPasswordCubit.formKeyResetPassword,
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svgs/reset.svg'),
                    Text(
                      AppConstants.resetPassword,
                      style: TextStyles.font20mainBllueColor,
                    ),
                    Text(
                      AppConstants.resetPasswordText,
                      textAlign: TextAlign.center,
                      style: TextStyles.font12black,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormFeild(
                      controller: forgetPasswordCubit.passwordController,
                      hintText: 'New Password',
                      kbType: TextInputType.number,
                      lableText: 'Enter Your New Password',
                      validator: (value) {
                        return ValidationErrorTexts.loginPasswordValidation(
                            value);
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormFeild(
                      controller: forgetPasswordCubit.confirmPasswordController,
                      hintText: 'Confirm Password',
                      kbType: TextInputType.number,
                      lableText: 'Confirm Your Password',
                      validator: (value) {
                        return ValidationErrorTexts.confirmPasswordValidation(
                          value,
                          forgetPasswordCubit.passwordController.text,
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    ButtonWidget(
                      AppConstants.reset,
                      color: Colors.white,
                      onPressed: () {
                        if (forgetPasswordCubit
                            .formKeyResetPassword.currentState!
                            .validate()) {
                          AuthReguests.resetPassword(
                              forgetPasswordCubit: forgetPasswordCubit,
                              resetPasswordModel: resetPasswordModel,
                              email: forgetPasswordCubit.emailController.text,
                              password:
                                  forgetPasswordCubit.passwordController.text,
                              passwordConfirmation: forgetPasswordCubit
                                  .confirmPasswordController.text);
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
