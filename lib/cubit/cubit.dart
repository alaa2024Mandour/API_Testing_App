import 'package:api_test/core/API/api_consumer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_test/cubit/status.dart';
import 'package:dio/dio.dart';

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

  signIn() async{
    try {
      emit(LoginLoadingStatus());
      final response = await Dio().post("https://food-api-omega.vercel.app/api/v1/user/signin", data: {
        "email":emailController.text,
        "password":passController.text,
      });
      emit(LoginSuccessStatus());
      print(response);
    } catch (e) {
      // TODO
      emit(LoginErrorStatus(e.toString()));

      print(e.toString());
    }
  }
}