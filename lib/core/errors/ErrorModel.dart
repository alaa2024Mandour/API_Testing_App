import 'package:api_test/core/API/end_points.dart';

import 'Exceptions.dart';
import 'package:dio/dio.dart';

class ErrorModel {
  final int status;
  final String ErrorMessage;

  ErrorModel({required this.status, required this.ErrorMessage});

  factory ErrorModel.fromJson(Map<String,dynamic> jsonData){
    return ErrorModel(
        status : jsonData[ApiKeys.status] ,
        ErrorMessage : jsonData[ApiKeys.errorMessage]);
  }


}

handeDioException (DioException e ){
  switch(e.type){
    case DioExceptionType.connectionTimeout:
      throw ServerException (errorModel: e.response!.data);
    case DioExceptionType.sendTimeout:
      throw ServerException (errorModel: e.response!.data);
    case DioExceptionType.receiveTimeout:
      throw ServerException (errorModel: e.response!.data);
    case DioExceptionType.badCertificate:
      throw ServerException (errorModel: e.response!.data);
    case DioExceptionType.cancel:
      throw ServerException (errorModel: e.response!.data);
    case DioExceptionType.connectionError:
      throw ServerException (errorModel: e.response!.data);
    case DioExceptionType.unknown:
      throw ServerException (errorModel: e.response!.data);
    case DioExceptionType.badResponse:
      switch(e.response!.statusCode){
        case 400: //bade request
          throw ServerException (errorModel: e.response!.data);
        case 401: //unauthorized
          throw ServerException (errorModel: e.response!.data);
        case 403: //forbidden
          throw ServerException (errorModel: e.response!.data);
        case 404: // not found
          throw ServerException (errorModel: e.response!.data);
        case 409: // coefficient
          throw ServerException (errorModel: e.response!.data);
        case 422: //processable entity
          throw ServerException (errorModel: e.response!.data);
        case 500: //ServerException
          throw ServerException (errorModel: e.response!.data);
      }
  }
}