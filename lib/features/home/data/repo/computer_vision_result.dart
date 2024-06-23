import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hack_talk/core/helpers/dio_helper.dart';
import 'package:hack_talk/core/helpers/end_points.dart';
import 'package:hack_talk/features/home/data/models/Computer_vision_model.dart';

class ComputerVisionRepository {
  Future<dynamic> getComputerVisionResult(File file) async {
    final response = await DioHelper.post(
      url: EndPoints.video,
      data: FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path),
      }),
    );

    final cVResultModel = (response.data["results"] as List<dynamic>)
        .map((e) => ComputerVisionModel.fromJson(e))
        .toList();
    final score = response.data["score"];

    return {
      "models": cVResultModel,
      "score": score,
    };
  }
}
