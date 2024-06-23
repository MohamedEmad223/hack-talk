import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hack_talk/features/auth/data/models/login_model.dart';
import 'package:hack_talk/features/auth/data/repo/login_repo.dart';
import 'package:hack_talk/features/auth/data/repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.signUpRepo,this.loginRepo) : super(AuthInitial());
  late SignUpRepo signUpRepo;
  late LoginRepo loginRepo;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool rememberMe = false;

  Future<void> signUp(String path, dynamic data) async {
    emit(RegisterLoading());
    final signUpModel = await signUpRepo.registerUser(
      path,
      data,
    );
    signUpModel.fold(
      ((error) {
        emit(RegisterFailed(error: error));
      }),
      ((signUpModel) {
        emit(RegisterSuccess());
      }),
    );
  }

  Future<void> login(String path, dynamic data) async {
    emit(LoginLoading());
    final loginModel = await loginRepo.loginUser(
      path,
      data,
    );
    loginModel.fold(
      ((error) {
        emit(LoginFailed(error: error));
      }),
      ((loginModel) {
        emit(LoginSuccess(loginModel));
      }),
    );
  }
}
