part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final ForgetPasswordModel forgetPasswordModel;

  ForgetPasswordSuccess(this.forgetPasswordModel);
}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordFailed extends ForgetPasswordState {
  final String? error;

  ForgetPasswordFailed({this.error});
}

final class CheckCodeSuccess extends ForgetPasswordState {
  final CheckCodeModel checkCodeModel;

  CheckCodeSuccess(this.checkCodeModel);
}

final class CheckCodeLoading extends ForgetPasswordState {}

final class CheckCodeFailed extends ForgetPasswordState {
  final String? error;

  CheckCodeFailed({this.error});
}

final class ResetPasswordSuccess extends ForgetPasswordState {
  final ResetPasswordModel resetPasswordModel;

  ResetPasswordSuccess(this.resetPasswordModel);
}

final class ResetPasswordLoading extends ForgetPasswordState {}

final class ResetPasswordFailed extends ForgetPasswordState {
  final String? error;

  ResetPasswordFailed({this.error});
}

