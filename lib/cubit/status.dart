class LoginFormStatus {}

class LoginInitialStatus extends LoginFormStatus {}

class LoginLoadingStatus extends LoginFormStatus {}

class LoginSuccessStatus extends LoginFormStatus {}

class LoginErrorStatus extends LoginFormStatus {
   final String errorMessage ;

  LoginErrorStatus(this.errorMessage);

}

class LoginChangePassStatus extends LoginFormStatus {}

class SignUpGetProfileImage extends LoginFormStatus {}

class SignUpInitialStatus extends LoginFormStatus {}

class SignUpLoadingStatus extends LoginFormStatus {}

class SignUpSuccessStatus extends LoginFormStatus {
  final String successMessage ;

  SignUpSuccessStatus({required this.successMessage});
}

class SignUpErrorStatus extends LoginFormStatus {
  final String errorMessage ;

  SignUpErrorStatus(this.errorMessage);

}