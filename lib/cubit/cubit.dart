import 'package:api_test/core/API/api_consumer.dart';
import 'package:api_test/core/API/end_points.dart';
import 'package:api_test/core/errors/Exceptions.dart';
import 'package:api_test/models/logIn_model.dart';
import 'package:api_test/models/signup_model.dart';
import 'package:api_test/shared/cachHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_test/cubit/status.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:image_picker/image_picker.dart';


class LoginCubit extends Cubit <LoginFormStatus> {
  LoginCubit(this.api) : super(LoginInitialStatus());
  final ApiConsumer api;
  static LoginCubit get(context) => BlocProvider.of(context);

  //================ SignUp Controllers =================
  var nameEmailController =TextEditingController();
  var signUpEmailController =TextEditingController();
  var signUpPassController =TextEditingController();
  var signUpRePassController =TextEditingController();
  var phoneEmailController =TextEditingController();

  //================ SignIn Controllers =================
  var emailController =TextEditingController();
  var passController =TextEditingController();
  var formKey = GlobalKey<FormState>();
  var signUpFormKey = GlobalKey<FormState>();

//===========password login form ============
  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(LoginChangePassStatus());
  }

  //============== UploadImage Function ===============
  XFile?  profilePicture ;
   uploadImage(XFile image ) async{
       profilePicture = image;
       emit(SignUpGetProfileImage());
   }
  //=============== SignIn Logic ===============
  LogInModel? user;
  signIn() async{
    try {
      emit(LoginLoadingStatus());
      final response = await api.post(
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
      emit(LoginErrorStatus(e.errorModel.ErrorMessage));
    }
  }

  signUp() async{
    try {
      emit(SignUpLoadingStatus());
     final response = await api.post(
          EndPoints.signUp,
          isFormData: true,
          data: {
            ApiKeys.name : nameEmailController.text,
            ApiKeys.email:signUpEmailController.text,
            ApiKeys.phone:phoneEmailController.text,
            ApiKeys.password:signUpPassController.text,
            ApiKeys.confirmPassword:signUpRePassController.text,
            ApiKeys.location:'{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          }
      );
     final signUpModel = SignUpModel.fromJson(response);
      emit(SignUpSuccessStatus(successMessage: signUpModel.message));
    } on ServerException catch (e) {
      // TODO
      emit(SignUpErrorStatus(e.errorModel.toString()));
    }
  }
}