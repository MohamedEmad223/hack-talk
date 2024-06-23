part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class ProfileLoading extends SettingsState {}

final class ProfileSuccess extends SettingsState {
  final ProfileModel profileModel;

  ProfileSuccess({required this.profileModel});
}

final class ProfileFailed extends SettingsState {
  final String? error;

  ProfileFailed({required this.error});
}

final class ChangePasswordSuccess extends SettingsState {
  final ChangePasswordModel changePasswordModel;

  ChangePasswordSuccess({required this.changePasswordModel});
}

final class ChangePasswordFailed extends SettingsState {
  final String? error;

  ChangePasswordFailed({required this.error});
}

final class ChangePasswordLoading extends SettingsState {}

final class LogoutSuccess extends SettingsState {
  final LogoutModel logoutModel;

  LogoutSuccess({required this.logoutModel});
}

final class LogoutFailed extends SettingsState {
  final String? error;

  LogoutFailed({required this.error});
}

final class LogoutLoading extends SettingsState {}
