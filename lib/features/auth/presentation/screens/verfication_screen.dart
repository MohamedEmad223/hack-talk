import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hack_talk/core/errors/validation/error_message.dart';
import 'package:hack_talk/core/helpers/app_constants.dart';
import 'package:hack_talk/core/helpers/auth_req.dart';
import 'package:hack_talk/core/helpers/cache_helper.dart';
import 'package:hack_talk/core/helpers/helper_methods.dart';
import 'package:hack_talk/core/routes/routes.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/theming/text_style.dart';
import 'package:hack_talk/core/widgets/button_sec.dart';
import 'package:hack_talk/core/widgets/button_widgets.dart';
import 'package:hack_talk/features/auth/data/models/check_code_model.dart';
import 'package:hack_talk/features/auth/logic/cubit/forget_password_cubit.dart';
import 'package:hack_talk/features/auth/presentation/widgets/app_bar.dart';
import 'package:hack_talk/features/auth/presentation/widgets/pin_put_them.dart';
import 'package:pinput/pinput.dart';

class VerficationScreen extends StatefulWidget {
  const VerficationScreen({super.key});

  @override
  State<VerficationScreen> createState() => _VerficationScreenState();
}

class _VerficationScreenState extends State<VerficationScreen> {
  late ForgetPasswordCubit forgetPasswordCubit;
  @override
  void initState() {
    forgetPasswordCubit = BlocProvider.of<ForgetPasswordCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    forgetPasswordCubit.codeController.dispose();
    forgetPasswordCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CheckCodeModel checkCodeModel = CheckCodeModel();
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is CheckCodeFailed) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error!));
        }
        if (state is CheckCodeSuccess) {
          Navigator.pushNamed(
            context,
            Routes.resetscreen,
          );
          HelperMethods.showCustomSnackBarSuccess(context, 'تم التحقق بنجاح');
        }
        if (state is CheckCodeLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset('assets/svgs/verification.svg'),
                  Text(
                    AppConstants.verification,
                    style: TextStyles.font20mainBllueColor,
                  ),
                  Text(
                    AppConstants.verificationText,
                    textAlign: TextAlign.center,
                    style: TextStyles.font12black,
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: forgetPasswordCubit.formKeyCode,
                    child: Pinput(
                        controller: forgetPasswordCubit.codeController,
                        length: 5,
                        obscuringCharacter: '•',
                        defaultPinTheme: defaultPinTheme,
                        autofocus: true,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration?.copyWith(
                            border: Border.all(
                              color: AppColors.mainColor,
                              width: 3,
                            ),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration?.copyWith(
                            color: const Color.fromRGBO(234, 239, 243, 1),
                          ),
                        ),
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) async {
                          await AuthReguests.checkCode(
                            forgetPasswordCubit: forgetPasswordCubit,
                            checkCodeModel: checkCodeModel,
                            email: CacheHelper().getData(key: 'email'),
                            code: forgetPasswordCubit.codeController.text,
                          );
                        }),
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {},
                    child: Text.rich(TextSpan(
                        text: AppConstants.doNot,
                        style: TextStyles.font12black,
                        children: const [
                          TextSpan(
                            text: AppConstants.resend,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                  ),
                  SizedBox(height: 10.h),
                  ButtonWidget(
                    AppConstants.verify,
                    color: Colors.white,
                    onPressed: () async {
                      if (forgetPasswordCubit.formKeyCode.currentState!
                          .validate()) {
                        await AuthReguests.checkCode(
                          forgetPasswordCubit: forgetPasswordCubit,
                          checkCodeModel: checkCodeModel,
                          email: CacheHelper().getData(key: 'email'),
                          code: forgetPasswordCubit.codeController.text,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  ButtonSec(
                    text: AppConstants.resend,
                    color: AppColors.mainColor,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
