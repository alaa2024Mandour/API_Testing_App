import 'package:api_test/cubit/cubit.dart';
import 'package:api_test/shared/componnent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/status.dart';

class SignIn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginCubit,LoginFormStatus>(
        listener: (context, state) {
          if (state is LoginSuccessStatus){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Success")));
          }else if (state is LoginErrorStatus){
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Image(image: AssetImage('assets/images/friendship.png')),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key:cubit.formKey ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextTitle(
                            title: 'Sign-in',
                            size: 30,
                          ),
                          SizedBox(height: 15,),
                          defaultTextFormField(
                            controller: cubit.emailController,
                            type: TextInputType.emailAddress,
                            hintText: 'Your Email',
                            labelText: 'Email',
                            preFix: Icons.email,
                          ),

                          SizedBox(height: 15,),


                          defaultTextFormField(
                            controller: cubit.passController,
                            type: TextInputType.visiblePassword,
                            hintText: 'Password',
                            labelText: 'Password',
                            preFix: Icons.lock_outline,
                            isPassword: cubit.isPassword,
                            suFix:  cubit.suffixIcon,
                            suffixOnPressed: (){
                              cubit.changePasswordVisibility();
                            },
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                defaultTextButton(
                                    function: (){},
                                    buttonlable: "Forgot Password ?")
                              ],
                            ),
                          ),

                          SizedBox(height: 25,),

                          state is LoginLoadingStatus ? Center(child: CircularProgressIndicator())  : defaultButton(
                            text: 'Sign in',
                            function: (){
                              if(cubit.formKey.currentState!.validate()){
                                cubit.signIn();
                              }
                            },
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an acount yet ....",
                              ),
                              defaultTextButton(
                                  function: (){},
                                  buttonlable: "Sign Up")
                            ],
                          )

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}


Widget TextTitle({
  required String title,
  required double size,
}) =>Text(
  "${title}",
  style: TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w900,

  ),
);