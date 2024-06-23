import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hack_talk/core/errors/exceptions/api_excptions.dart';
import 'package:hack_talk/core/networking/api_services.dart';
import 'package:hack_talk/features/setting/change_password/data/models/change_password_model.dart';

class ChangePasswordRepo {
  late ApiServices apiServices;
  ChangePasswordRepo(this.apiServices);
  Future<Either<String, ChangePasswordModel>> profileChanege(
    String path,
    String token,
    dynamic data,
  ) async {
    try {
      var response = await apiServices.post(path,
          data: data,
          isFormData: true,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      ChangePasswordModel result = ChangePasswordModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return left(e.errorModel.message!);
    }
  }

}
