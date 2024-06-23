import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hack_talk/core/errors/exceptions/api_excptions.dart';
import 'package:hack_talk/core/networking/api_services.dart';
import 'package:hack_talk/features/setting/personal_information/data/models/profile_model.dart';

class ProfileRepo {
  late ApiServices apiServices;
  ProfileRepo(
    this.apiServices,
  );
  Future<Either<String, ProfileModel>> profileChanege(
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
      ProfileModel result = ProfileModel.fromJson(response);
      return Right(result);
    } on ApiException catch (e) {
      return left(e.errorModel.message!);
    }
  }
}
