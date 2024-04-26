// received response after signIn
import 'package:api_test/core/API/end_points.dart';

class LogInModel{
  final String message;
  final String token;

  LogInModel(this.message, this.token);

  factory LogInModel.fromJson(Map<String,dynamic>jsonData){
    return LogInModel(
        jsonData[ApiKeys.message],
      jsonData[ApiKeys.token],);
  }
}