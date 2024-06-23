import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hack_talk/core/errors/exceptions/api_excptions.dart';
import 'package:hack_talk/core/networking/api_services.dart';
import 'package:hack_talk/features/home/data/models/log_out.dart';

class LogoutRepo {
  late ApiServices apiServices;
  LogoutRepo(this.apiServices);
  Future<Either<String, LogoutModel>> logout(
    String path,
    String token,
  ) async {
    try {
      var response = await apiServices.post(path,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
          LogoutModel result = LogoutModel.fromJson(response.data);
          return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
