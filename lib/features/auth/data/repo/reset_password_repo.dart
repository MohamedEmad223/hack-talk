import 'package:dartz/dartz.dart';
import 'package:hack_talk/core/errors/exceptions/api_excptions.dart';
import 'package:hack_talk/core/networking/api_services.dart';
import 'package:hack_talk/features/auth/data/models/reset_password_model.dart';

class ResetPasswordRepo {
  late ApiServices apiServices;
  ResetPasswordRepo(this.apiServices);
  Future<Either<String,ResetPasswordModel>> resetPassword(
    String path,
    dynamic data,
  ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = ResetPasswordModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
