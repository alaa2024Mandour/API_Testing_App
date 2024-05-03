import 'dart:io';
import 'package:api_test/user/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/status.dart';
import '../cubit/cubit.dart';
import '../shared/component.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return   BlocConsumer<LoginCubit,LoginFormStatus>(
            listener: (context, state) {
              if(state is SignUpSuccessStatus){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(state.successMessage)));
              }
              else if (state is SignUpErrorStatus){
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              var cubit = LoginCubit.get(context);
              return   Scaffold(
                body:  Padding(
                  padding: const EdgeInsets.only(top: 50.0 , left: 20, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          textTitle(
                            title: 'Sign-Up',
                            size: 30,
                          ),
                          const SizedBox(height:20 ,),
                           Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                cubit.profilePicture==null?
                                const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: AssetImage("assets/images/avatar.png"),
                                )
                                    :CircleAvatar(
                                  radius: 64,
                                  backgroundImage: FileImage(File(cubit.profilePicture!.path)),
                                ) ,
                                Positioned(
                                  child: IconButton(
                                  onPressed: () {
                                    ImagePicker().pickImage(source: ImageSource.gallery)
                                        .then((value) => cubit.uploadImage(value!));

                                  },
                                  icon: const Icon( Icons.add_a_photo , color: Colors.white,),),)
                              ],
                            ),
                          ),
                          Form(
                            key:cubit.signUpFormKey ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultTextFormField(
                                  controller: cubit.nameEmailController,
                                  type: TextInputType.name,
                                  hintText: 'Your Name',
                                  labelText: 'Name',
                                  preFix: Icons.person,
                                ),
                                const SizedBox(height: 15,),
                                defaultTextFormField(
                                  controller: cubit.signUpEmailController,
                                  type: TextInputType.emailAddress,
                                  hintText: 'Email Address',
                                  labelText: 'Your Email',
                                  preFix: Icons.email,
                                ),

                                const SizedBox(height: 15,),

                                defaultTextFormField(
                                  controller: cubit.phoneEmailController,
                                  type: TextInputType.phone,
                                  hintText:'Phone Number' ,
                                  labelText: 'Your Phone',
                                  preFix: Icons.phone_android,
                                ),

                                const SizedBox(height: 15,),

                                defaultTextFormField(
                                  controller: cubit.signUpPassController,
                                  type: TextInputType.visiblePassword,
                                  hintText: 'Password',
                                  labelText: 'Your Password',
                                  preFix: Icons.lock_outline,
                                  isPassword: cubit.isPassword,
                                  suFix:  cubit.suffixIcon,
                                  suffixOnPressed: (){
                                    cubit.changePasswordVisibility();
                                  },
                                ),

                                const SizedBox(height: 15,),

                                defaultTextFormField(
                                  controller: cubit.signUpRePassController,
                                  type: TextInputType.visiblePassword,
                                  hintText: 'Confirm Password',
                                  labelText: 'Confirm Password',
                                  preFix: Icons.lock_outline,
                                  isPassword: cubit.isPassword,
                                  suFix:  cubit.suffixIcon,
                                  suffixOnPressed: (){
                                    cubit.changePasswordVisibility();
                                  },
                                ),

                               const SizedBox(height: 25,),

                                state is SignUpLoadingStatus
                                    ?const Center(child: CircularProgressIndicator())
                                    : defaultButton(
                                  text: 'Sign Up',
                                  function: (){
                                    if(cubit.signUpFormKey.currentState!.validate()){
                                      cubit.signUp();
                                    }
                                  },
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account ....",
                                    ),
                                    defaultTextButton(
                                        function: (){
                                          navigateTo(context,SignIn());
                                        },
                                        buttonlable: "Sign In")
                                  ],
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        );
  }
}
