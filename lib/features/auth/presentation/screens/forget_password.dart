import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hack_talk/core/errors/validation/error_message.dart';
import 'package:hack_talk/core/errors/validation/validation_error_message.dart';
import 'package:hack_talk/core/helpers/app_constants.dart';
import 'package:hack_talk/core/helpers/auth_req.dart';
import 'package:hack_talk/core/helpers/helper_methods.dart';
import 'package:hack_talk/core/routes/routes.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/theming/text_style.dart';
import 'package:hack_talk/core/widgets/button_sec.dart';
import 'package:hack_talk/core/widgets/button_widgets.dart';
import 'package:hack_talk/core/widgets/custom_text_feild.dart';
import 'package:hack_talk/features/auth/data/models/forget_password_model.dart';
import 'package:hack_talk/features/auth/logic/cubit/forget_password_cubit.dart';
import 'package:hack_talk/features/auth/presentation/widgets/app_bar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late ForgetPasswordCubit forgetPasswordCubit;
  @override
  void initState() {
    forgetPasswordCubit = BlocProvider.of<ForgetPasswordCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    forgetPasswordCubit.emailController.dispose();
    forgetPasswordCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {},
      child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordFailed) {
            Navigator.pop(context);
            HelperMethods.showCustomSnackBarError(
                context, ErrorMessages.errorMessage(state.error!));
          }
          if (state is ForgetPasswordLoading) {
            HelperMethods.showLoadingAlertDialog(context);
          }
          if (state is ForgetPasswordSuccess) {
            Navigator.pushNamed(context, Routes.verification);
            HelperMethods.showCustomSnackBarSuccess(
                context, 'Verification Code Sent Successfully');
          }
        },
        child: Scaffold(
          appBar: const CustomAppBar(),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svgs/forget.svg'),
                    Text(
                      AppConstants.forgotPassword,
                      style: TextStyles.font20mainBllueColor,
                    ),
                    Text(
                      AppConstants.doNotWorry,
                      textAlign: TextAlign.center,
                      style: TextStyles.font12black,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormFeild(
                      controller: forgetPasswordCubit.emailController,
                      hintText: 'Email',
                      kbType: TextInputType.emailAddress,
                      lableText: 'Enter Your Email',
                      validator: (value) {
                        return ValidationErrorTexts.emailValidation(value);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ButtonWidget(
                      AppConstants.send,
                      color: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthReguests.forgetPassword(
                              forgetPasswordCubit: forgetPasswordCubit,
                              forgetPasswordModel: forgetPasswordModel,
                              email: forgetPasswordCubit.emailController.text);
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
          )),
        ),
      ),
    );
  }
}
