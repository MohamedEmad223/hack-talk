import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hack_talk/core/helpers/app_constants.dart';
import 'package:hack_talk/core/helpers/cache_helper.dart';
import 'package:hack_talk/features/home/data/models/log_out.dart';
import 'package:hack_talk/features/home/data/repo/logout_repo.dart';
import 'package:hack_talk/features/setting/change_password/data/models/change_password_model.dart';
import 'package:hack_talk/features/setting/change_password/data/repo/change_password_repo.dart';
import 'package:hack_talk/features/setting/personal_information/data/models/profile_model.dart';
import 'package:hack_talk/features/setting/personal_information/data/repo/profile_repo.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.profileRepo, this.changePasswordRepo, this.logoutRepo)
      : super(SettingsInitial());
  late ProfileRepo profileRepo;
  late ChangePasswordRepo changePasswordRepo;
  late LogoutRepo logoutRepo;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> getProfile(
    String path,
    dynamic data,
  ) async {
    emit(ProfileLoading());
    var resrponse = await profileRepo.profileChanege(
        path, CacheHelper().getData(key: AppConstants.token), data);
    resrponse.fold((error) {
      emit(ProfileFailed(error: error));
    }, (profileModel) {
      emit(ProfileSuccess(profileModel: profileModel));
    });
  }

  final currentPasswored = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  Future<void> changePassword(
    String path,
    dynamic data,
  ) async {
    emit(ChangePasswordLoading());
    var resrponse = await changePasswordRepo.profileChanege(
        path, CacheHelper().getData(key: AppConstants.token), data);
    resrponse.fold((error) {
      emit(ChangePasswordFailed(error: error));
    }, (changePasswordModel) {
      emit(ChangePasswordSuccess(changePasswordModel: changePasswordModel));
    });
  }

  Future<void> logout(
    String path,
  ) async {
    emit(LogoutLoading());
    var resrponse = await logoutRepo.logout(
        path, CacheHelper().getData(key: AppConstants.token));
    resrponse.fold((error) {
      emit(LogoutFailed(error: error));
    }, (logoutModel) {
      emit(LogoutSuccess(logoutModel: logoutModel));
    });
  }
}
