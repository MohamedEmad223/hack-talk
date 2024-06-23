part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterFailed extends AuthState {
  final String? error;

  RegisterFailed({this.error});
}

final class LoginSuccess extends AuthState {
  final LoginModel loginModel;

  LoginSuccess(this.loginModel);
}

final class LoginLoading extends AuthState {}

final class LoginFailed extends AuthState {
  final String? error;

  LoginFailed({this.error});
}
