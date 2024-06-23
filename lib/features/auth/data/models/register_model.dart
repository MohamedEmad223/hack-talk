import 'package:json_annotation/json_annotation.dart';
part 'register_model.g.dart';

@JsonSerializable()
class SignUpModel {
  final String? message;
  final int? status;
  final String? name, email, password;
  @JsonKey(name: 'password_confirmation')
  final String? passwordConfirmation;


  SignUpModel({
    this.message,
    this.status,
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson(SignUpModel signUpModel) =>
      _$SignUpModelToJson(signUpModel);
}
