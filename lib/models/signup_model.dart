import '../core/API/end_points.dart';

class SignUpModel{
  final String message;

  SignUpModel(this.message);

  factory SignUpModel.fromJson(Map<String,dynamic>jsonData){
    return SignUpModel(
      jsonData[ApiKeys.message]
    );
  }
}