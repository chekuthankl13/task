import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task/db/hive_helper.dart';
import 'package:task/logic/bloc_exports.dart';
import 'package:task/presentation/auth/login_screen.dart';
import 'package:task/presentation/auth/register_screen.dart';
import 'package:task/presentation/home/home_screen.dart';
import 'package:task/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      bool isCred = HiveHelpers.credBox.isEmpty;
      bool islog = HiveHelpers.loginBox.isEmpty;

      if (isCred) {
        navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: const LoginScreen(),
            ),
          ),
        );
      } else if (islog) {
        navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: const LoginScreen(),
            ),
          ),
        );
      } else {
        navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen(cred: HiveHelpers.credBox.values.first)),
        );
      }

      // navigatorKey.currentState!.push(MaterialPageRoute(
      //   builder: (context) => BlocProvider(
      //     create: (context) => AuthCubit(),
      //     child:const RegisterScreen(),
      //   ),
      // ),
      // );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: sW(context) / 2,
          child: const LinearProgressIndicator(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
