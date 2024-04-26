class LoginFormStatus {}

class LoginInitialStatus extends LoginFormStatus {}

class LoginLoadingStatus extends LoginFormStatus {}

class LoginSuccessStatus extends LoginFormStatus {}

class LoginErrorStatus extends LoginFormStatus {
   final String errorMessage ;

  LoginErrorStatus(this.errorMessage);

}

class LoginChangePassStatus extends LoginFormStatus {}