import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'lang': 'ar',
        }));
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String? token = '',
    String lang = 'ar',
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    String? token = '',
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio.post(
      path,
      data: data,
    );
  }

  static Future<Response> putData({
    required String path,
    required Map<String, dynamic> data,
    String? token = '',
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio.put(
      path,
      data: data,
    );
  }
}
