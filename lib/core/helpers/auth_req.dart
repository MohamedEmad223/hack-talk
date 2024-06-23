import 'package:hack_talk/core/helpers/cache_helper.dart';
import 'package:hack_talk/core/helpers/end_points.dart';
import 'package:hack_talk/features/auth/data/models/check_code_model.dart';
import 'package:hack_talk/features/auth/data/models/forget_password_model.dart';
import 'package:hack_talk/features/auth/data/models/login_model.dart';
import 'package:hack_talk/features/auth/data/models/register_model.dart';
import 'package:hack_talk/features/auth/data/models/reset_password_model.dart';
import 'package:hack_talk/features/auth/logic/cubit/auth_cubit.dart';
import 'package:hack_talk/features/auth/logic/cubit/forget_password_cubit.dart';

class AuthReguests {
  AuthReguests._();
  static Future signUp({
    required AuthCubit authCubit,
    required SignUpModel signUpModel,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    await authCubit
        .signUp(
      EndPoints.register,
      signUpModel.toJson(SignUpModel(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      )),
    )
        .then((value) {
      CacheHelper cacheHelper = CacheHelper();
      cacheHelper.saveData(
        key: 'email',
        value: email,
      );
      cacheHelper.saveData(
        key: 'password',
        value: password,
      );
      cacheHelper.saveData(
        key: 'name',
        value: name,
      );
      cacheHelper.saveData(
        key: 'passwordConfirmation',
        value: passwordConfirmation,
      );
    });
  }

  static Future login({
    required AuthCubit authCubit,
    required LoginModel loginModel,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await authCubit.login(
      EndPoints.login,
      loginModel.toJson(
        LoginModel(
          email: email,
          password: password,
          rememberMe: rememberMe,
        ),
      ),
    );
  }

  static Future forgetPassword({
    required ForgetPasswordCubit forgetPasswordCubit,
    required ForgetPasswordModel forgetPasswordModel,
    required String email,
  }) async {
    await forgetPasswordCubit.forgetPassword(
        EndPoints.forgetPassword,
        forgetPasswordModel.toJson(
          ForgetPasswordModel(
            email: email,
          ),
        ));
  }

  static Future checkCode({
    required ForgetPasswordCubit forgetPasswordCubit,
    required CheckCodeModel checkCodeModel,
    required String email,
    required String code,
  }) async {
    await forgetPasswordCubit.checkCode(
        EndPoints.checkCode,
        checkCodeModel.toJson(
          CheckCodeModel(
            email: email,
            token: code,
          ),
        ));
  }

  static Future resetPassword({
    required ForgetPasswordCubit forgetPasswordCubit,
    required ResetPasswordModel resetPasswordModel,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    await forgetPasswordCubit.resetPassword(
        EndPoints.resetPassword,
        resetPasswordModel.toJson(
          ResetPasswordModel(
            email: email,
            newPasswordConfirmation: passwordConfirmation,
            newpassword: password,
          ),
        ));
  }
}
