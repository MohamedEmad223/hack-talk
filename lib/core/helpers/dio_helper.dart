import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class DioHelper {
  DioHelper._();
  static late Dio dio;
  static late Dio dioAi;
  static init() {
    

    dioAi = Dio(
      BaseOptions(
        baseUrl: 'https://acd9-156-203-170-197.ngrok-free.app/',
        receiveDataWhenStatusError: true,
      ),
    );
    if (kDebugMode) {
      dioAi.interceptors.add(PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ));
    }
  }

 
 

  static Future<Response> post(
      {required String url,
      Map<String, dynamic>? query,
      required dynamic data,
      String lang = 'en'}) async {
    dioAi.options.headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    };
    return dioAi.post(url, queryParameters: query, data: data);
  }
}
