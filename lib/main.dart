import 'package:api_test/core/API/dio_consumer.dart';
import 'package:api_test/cubit/cubit.dart';
import 'package:api_test/cubit/status.dart';
import 'package:api_test/shared/cachHelper.dart';
import 'package:api_test/user/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CachHelper.init;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (BuildContext context) => LoginCubit(DioConsumer(Dio())),)
      ],
      child: BlocConsumer<LoginCubit,LoginFormStatus>(
          listener: (context , state){},
          builder: (context , state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
                useMaterial3: true,
                fontFamily: 'NotoSerif',
              ),
              home: SignIn(),
            );
          }
      ),
    );
  }
}



