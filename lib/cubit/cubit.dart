import 'package:api_test/core/API/api_consumer.dart';
import 'package:api_test/core/API/end_points.dart';
import 'package:api_test/core/errors/Exceptions.dart';
import 'package:api_test/models/logIn_model.dart';
import 'package:api_test/shared/cachHelper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_test/cubit/status.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class LoginCubit extends Cubit <LoginFormStatus> {
  LoginCubit(this.API) : super(LoginInitialStatus());
  final ApiConsumer API;
  static LoginCubit get(context) => BlocProvider.of(context);

  //================ Controllers =================
  var emailController =TextEditingController();
  var passController =TextEditingController();

  var formKey = GlobalKey<FormState>();

//===========password login form ============

  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(LoginChangePassStatus());
  }

  LogInModel? user;
  signIn() async{
    try {
      emit(LoginLoadingStatus());
      final response = await API.post(
          EndPoints.logIn,
          data: {
            ApiKeys.email:emailController.text,
            ApiKeys.password:passController.text,
      });
      user=LogInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user!.token);
      CachHelper.saveData(key: ApiKeys.token, value: user!.token);
      CachHelper.saveData(key: ApiKeys.id, value: decodedToken[ApiKeys.id]);
      print(decodedToken['id']);
      emit(LoginSuccessStatus());
      print(response);
    } on ServerException catch (e) {
      // TODO
      emit(LoginErrorStatus(e.errorModel.ErrorMessage));
    }
  }
}