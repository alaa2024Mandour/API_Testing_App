import 'package:api_test/core/API/api_consumer.dart';
import 'package:api_test/core/API/api_interceptors.dart';
import 'package:api_test/core/API/end_points.dart';
import 'package:dio/dio.dart';
import '../errors/ErrorModel.dart';
import '../errors/Exceptions.dart';
class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio){
    dio.options.baseUrl=EndPoints.basURL;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true
    ));
  }

  @override
  Future delete(
      String path, {dynamic data, Map<String, dynamic>? queryParameters,bool isFormData = false}) async {
     try {
       final response = await dio.delete(
          path,
          data: isFormData? FormData.fromMap(data) : data,
          queryParameters: queryParameters,

        );

       return response.data;
     } on DioException catch (e) {
          handeDioException(e);
       }
  }

  @override
  Future get(String path, {dynamic data, Map<String, dynamic>? queryParameters,bool isFormData = false}) async {
    try {
      final response = await dio.get(
        path,
        data: isFormData? FormData.fromMap(data) : data,
        queryParameters: queryParameters,

      );

      return response.data;
    } on DioException catch (e) {
      handeDioException(e);
    }
  }

  @override
  Future patch(String path, {dynamic data, Map<String, dynamic>? queryParameters,bool isFormData = false}) async{
    try {
      final response = await dio.patch(
        path,
        data: isFormData? FormData.fromMap(data) : data,
        queryParameters: queryParameters,

      );

      return response.data;
    } on DioException catch (e) {
      handeDioException(e);
    }
  }

  @override
  Future post(String path, {dynamic data, Map<String, dynamic>? queryParameters,bool isFormData = false}) async{
    try {
      final response = await dio.post(
        path,
        data: isFormData? FormData.fromMap(data) : data,
        queryParameters: queryParameters,

      );

      return response.data;
    } on DioException catch (e) {
      handeDioException(e);
    }
  }

}