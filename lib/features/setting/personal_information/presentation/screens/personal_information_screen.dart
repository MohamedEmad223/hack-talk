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
import 'package:hack_talk/core/widgets/button_widgets.dart';
import 'package:hack_talk/core/widgets/custom_text_feild.dart';
import 'package:hack_talk/features/setting/logic/cubit/settings_cubit.dart';

import '../../../../../core/widgets/button_sec.dart';

class PersonInformationScreen extends StatefulWidget {
  const PersonInformationScreen({super.key});

  @override
  State<PersonInformationScreen> createState() =>
      _PersonInformationScreenState();
}

class _PersonInformationScreenState extends State<PersonInformationScreen> {
  late SettingsCubit settingsCubit;
  @override
  void initState() {
    settingsCubit = BlocProvider.of<SettingsCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    settingsCubit.nameController.dispose();
    settingsCubit.emailController.dispose();
    settingsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          HelperMethods.showCustomSnackBarSuccess(
              context, state.profileModel.message!);
        }
        if (state is ProfileFailed) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error));
        }
        if (state is ProfileLoading) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("name"),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit))
                      ],
                    ),
                    CustomTextFormFeild(
                      controller: settingsCubit.nameController,
                      hintText: 'name',
                      kbType: TextInputType.name,
                      lableText: 'Enter name',
                      validator: (value) {
                        return ValidationErrorTexts.nameValidation(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("email"),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit))
                      ],
                    ),
                    CustomTextFormFeild(
                      controller: settingsCubit.emailController,
                      hintText: 'email',
                      kbType: TextInputType.emailAddress,
                      lableText: 'enter email',
                      validator: (value) {
                        return ValidationErrorTexts.emailValidation(value);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ButtonWidget(
                      "update change",
                      color: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          settingsCubit.getProfile(
                              EndPoints.profileChange,
                              settingsCubit
                                  .getProfile(EndPoints.profileChange, {
                                "name": settingsCubit.nameController.text,
                                "email": settingsCubit.emailController.text
                              }));
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    ButtonSec(
                      text: AppConstants.cancel,
                      color: AppColors.mainColor,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ))),
    );
  }
}
