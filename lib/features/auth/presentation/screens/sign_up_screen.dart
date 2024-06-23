import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hack_talk/core/errors/validation/error_message.dart';
import 'package:hack_talk/core/helpers/app_constants.dart';
import 'package:hack_talk/core/helpers/auth_req.dart';
import 'package:hack_talk/core/helpers/helper_methods.dart';
import 'package:hack_talk/core/routes/routes.dart';
import 'package:hack_talk/core/theming/assets.dart';
import 'package:hack_talk/core/theming/text_style.dart';

import 'package:hack_talk/core/widgets/button_widgets.dart';
import 'package:hack_talk/core/widgets/custom_text_feild.dart';
import 'package:hack_talk/features/auth/data/models/register_model.dart';
import 'package:hack_talk/features/auth/logic/cubit/auth_cubit.dart';
import 'package:hack_talk/features/auth/presentation/widgets/app_bar.dart';
import 'package:hack_talk/features/auth/presentation/widgets/div.dart';
import 'package:hack_talk/features/auth/presentation/widgets/new_hackTalk.dart';
import 'package:hack_talk/features/auth/presentation/widgets/social_login.dart';

import '../../../../core/errors/validation/validation_error_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthCubit authCubit;
  @override
  void initState() {
    authCubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  bool isObsecuretext = true;
  bool _isPasswordVisible = false;
  bool _isPasswordVisibleone = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    authCubit.emailController.dispose();
    authCubit.passwordController.dispose();
    authCubit.passwordConfirmationController.dispose();
    authCubit.nameController.dispose();
    super.dispose();
    authCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    SignUpModel signUpModel = SignUpModel();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarSuccess(context, "Register Success");
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
        }
        if (state is RegisterFailed) {
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error));
        }
        if (state is RegisterLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.h),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Center(child: Image.asset('assets/images/signUp.png')),
                      Text(
                        AppConstants.createAccount,
                        style: TextStyles.font24mainBlueColor,
                      ),
                      Text(AppConstants.pleaseSignuptocontinueusingourapp,
                          style: TextStyles.font11black),
                      SizedBox(height: 5.h),
                      CustomTextFormFeild(
                        lableText: ' Name ',
                        hintText: AppConstants.name,
                        kbType: TextInputType.name,
                        controller: authCubit.nameController,
                        validator: (value) {
                          return ValidationErrorTexts.nameValidation(value);
                        },
                      ),
                      CustomTextFormFeild(
                        lableText: ' Email  ',
                        hintText: AppConstants.email,
                        kbType: TextInputType.emailAddress,
                        controller: authCubit.emailController,
                        validator: (value) {
                          return ValidationErrorTexts.emailValidation(value);
                        },
                      ),
                      CustomTextFormFeild(
                        lableText: ' Password ',
                        isObscureText: !_isPasswordVisibleone,
                        suffixIcon: IconButton(
                          icon: SvgPicture.asset(
                            _isPasswordVisible ? Assets.eye : Assets.closeEye,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        hintText: AppConstants.password,
                        kbType: TextInputType.number,
                        controller: authCubit.passwordController,
                        validator: (value) {
                          return ValidationErrorTexts.signUpPasswordValidation(
                              value);
                        },
                      ),
                      CustomTextFormFeild(
                        lableText: ' Conform Password',
                        isObscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: SvgPicture.asset(
                            _isPasswordVisible ? Assets.eye : Assets.closeEye,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        hintText: AppConstants.password,
                        kbType: TextInputType.number,
                        controller: authCubit.passwordConfirmationController,
                        validator: (value) {
                          return ValidationErrorTexts.signUpPasswordValidation(
                              value);
                        },
                      ),
                      SizedBox(height: 10.h),
                      ButtonWidget(AppConstants.signUp, color: Colors.white,
                          onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthReguests.signUp(
                              authCubit: authCubit,
                              signUpModel: signUpModel,
                              email: authCubit.emailController.text,
                              password: authCubit.passwordController.text,
                              passwordConfirmation:
                                  authCubit.passwordConfirmationController.text,
                              name: authCubit.nameController.text);
                        }
                      }),
                      SizedBox(height: 10.h),
                      NewToHachTalk(
                        textOne: AppConstants.donothaveanAccount,
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                            (route) => false,
                            
                          );
                        },
                        textTwo: AppConstants.login,
                      ),
                      const Div(),
                      const Social_icon(),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
