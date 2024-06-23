// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:hack_talk/core/errors/exceptions/api_excptions.dart';
import 'package:hack_talk/core/networking/api_services.dart';
import 'package:hack_talk/features/auth/data/models/check_code_model.dart';

class CheckCodeRepo {
  late ApiServices apiServices;
  CheckCodeRepo(
     this.apiServices,
  );
   Future<Either<String,CheckCodeModel>> checkCode(
    String path,
    dynamic data,
  ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = CheckCodeModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
