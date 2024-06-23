import 'package:dartz/dartz.dart';
import 'package:hack_talk/core/errors/exceptions/api_excptions.dart';
import 'package:hack_talk/core/networking/api_services.dart';
import 'package:hack_talk/features/auth/data/models/register_model.dart';

class SignUpRepo {
  late ApiServices apiServices;
  SignUpRepo(this.apiServices);
  Future<Either<String, SignUpModel>> registerUser(
      
         String path,
         dynamic data,
      ) async {
    try {
      var response = await apiServices.post(
        path,
        data: data,
      );
      var result = SignUpModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return Left(e.errorModel.message!);
    }
  }
}
