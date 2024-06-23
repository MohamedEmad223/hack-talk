import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hack_talk/features/auth/data/models/check_code_model.dart';
import 'package:hack_talk/features/auth/data/models/forget_password_model.dart';
import 'package:hack_talk/features/auth/data/models/reset_password_model.dart';
import 'package:hack_talk/features/auth/data/repo/check_code_repo.dart';
import 'package:hack_talk/features/auth/data/repo/forget_password_repo.dart';
import 'package:hack_talk/features/auth/data/repo/reset_password_repo.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordRepo) : super(ForgetPasswordInitial());
  late ForgetPasswordRepo forgetPasswordRepo;
  TextEditingController emailController = TextEditingController();
  Future<void> forgetPassword(String path, dynamic data) async {
    emit(ForgetPasswordLoading());
    final forgetPassword = await forgetPasswordRepo.forgetPassword(
      path,
      data,
    );
    forgetPassword.fold((error) {
      emit(ForgetPasswordFailed(error: error));
    }, (forgetPassword) {
      emit(ForgetPasswordSuccess( forgetPassword));
    });
  }

   TextEditingController codeController = TextEditingController();
  GlobalKey<FormState> formKeyCode = GlobalKey<FormState>();

  late CheckCodeRepo checkCodeRepo;
  Future<void> checkCode(String path, dynamic data) async {
    emit(CheckCodeLoading());
    final forgetPassword = await checkCodeRepo.checkCode(
      path,
      data,
    );
    forgetPassword.fold((error) {
      emit(CheckCodeFailed(error: error));
    }, (checkCode) {
      emit(CheckCodeSuccess(checkCode));
    });
  }


TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKeyResetPassword = GlobalKey<FormState>();

  late ResetPasswordRepo resetPasswordRepo;
  Future<void> resetPassword(String path, dynamic data) async {
    emit(ResetPasswordLoading());
    final forgetPassword = await resetPasswordRepo.resetPassword(
      path,
      data,
    );
    forgetPassword.fold((error) {
      emit(ResetPasswordFailed(error: error));
    }, (resetPassword) {
      emit(ResetPasswordSuccess( resetPassword));
    });
  }
}
