import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hack_talk/core/errors/validation/error_message.dart';
import 'package:hack_talk/core/errors/validation/validation_error_message.dart';
import 'package:hack_talk/core/helpers/app_constants.dart';
import 'package:hack_talk/core/helpers/auth_req.dart';
import 'package:hack_talk/core/helpers/cache_helper.dart';
import 'package:hack_talk/core/helpers/helper_methods.dart';
import 'package:hack_talk/core/routes/routes.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/theming/assets.dart';
import 'package:hack_talk/core/theming/text_style.dart';
import 'package:hack_talk/core/widgets/button_widgets.dart';
import 'package:hack_talk/core/widgets/custom_text_feild.dart';
import 'package:hack_talk/features/auth/data/models/login_model.dart';
import 'package:hack_talk/features/auth/logic/cubit/auth_cubit.dart';
import 'package:hack_talk/features/auth/presentation/widgets/app_bar.dart';
import 'package:hack_talk/features/auth/presentation/widgets/div.dart';
import 'package:hack_talk/features/auth/presentation/widgets/new_hackTalk.dart';
import 'package:hack_talk/features/auth/presentation/widgets/social_login.dart';
import 'package:hack_talk/features/home/presentation/screen/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthCubit authCubit;
  bool isSwitched = false;

  @override
  void initState() {
    authCubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    authCubit.emailController.dispose();
    authCubit.passwordController.dispose();
    super.dispose();
    authCubit.close();
    return;
  }

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    LoginModel loginModel = LoginModel();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
          CacheHelper().saveData(
              key: AppConstants.token, value: state.loginModel.data!['access_token']);
          CacheHelper().saveData(key: 'rememberMe', value: isSwitched);
        }
        if (state is LoginFailed) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error));
        }
        if (state is LoginLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
      },
      child: Scaffold(
          appBar: const CustomAppBar(),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: SvgPicture.asset(Assets.login)),
                    Text(
                      AppConstants.welcomBack,
                      textAlign: TextAlign.left,
                      style: TextStyles.font24mainBlueColor,
                    ),
                    Text(AppConstants.please, style: TextStyles.font11black),
                    SizedBox(height: 15.h),
                    CustomTextFormFeild(
                      hintText: AppConstants.email,
                      kbType: TextInputType.emailAddress,
                      controller: authCubit.emailController,
                      validator: (value) {
                        return ValidationErrorTexts.emailValidation(value);
                      },
                      lableText: 'Email',
                      isObscureText: false,
                    ),
                    SizedBox(height: 7.h),
                    CustomTextFormFeild(
                      lableText: 'Password',
                      hintText: AppConstants.password,
                      kbType: TextInputType.visiblePassword,
                      controller: authCubit.passwordController,
                      validator: (value) {
                        return ValidationErrorTexts.loginPasswordValidation(
                            value);
                      },
                      isObscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          _isPasswordVisible ? Assets.eye : Assets.closeEye,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
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
                        Text(AppConstants.rememberMe,
                            style: TextStyles.font11black),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.forgetPassword,
                            );
                          },
                          child: Text(
                            AppConstants.forgotPassword,
                            style: TextStyles.font11black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    ButtonWidget(
                      AppConstants.login,
                      color: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthReguests.login(
                              authCubit: authCubit,
                              loginModel: loginModel,
                              email: authCubit.emailController.text,
                              password: authCubit.passwordController.text,
                              rememberMe: authCubit.rememberMe);
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    Center(
                        child: NewToHachTalk(
                      textOne: AppConstants.donothaveanAccount,
                      onTap: () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                      textTwo: AppConstants.signUp,
                    )),
                    SizedBox(height: 10.h),
                    const Div(),
                    SizedBox(height: 10.h),
                    const Social_icon()
                  ],
                ),
              ),
            ),
          ))),
    );
  }
}
