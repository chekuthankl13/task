import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/logic/bloc_exports.dart';
import 'package:task/presentation/auth/register_screen.dart';
import 'package:task/presentation/auth/widgets/widget.dart';
import 'package:task/presentation/home/home_screen.dart';
import 'package:task/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameCntr = TextEditingController();
  TextEditingController mobileCntr = TextEditingController();

  GlobalKey<FormState> fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.withOpacity(.2),
      body: Center(
        child: Container(
          height: sH(context) / 2,
          width: sW(context) - 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
              key: fkey,
              child: ListView(
                padding: const EdgeInsets.all(15),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [
                  spaceHeight(5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  spaceHeight(40),
                  AuthWidgets().field(
                      cntr: nameCntr,
                      txt: "First Name",
                      ic: CupertinoIcons.person),
                  spaceHeight(20),
                  AuthWidgets().field(
                      cntr: mobileCntr,
                      isNumber: true,
                      txt: "Mobile no",
                      ic: CupertinoIcons.phone),
                  spaceHeight(20),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoadError) {
                        errorToast(context, error: state.error);
                      }
                      if (state is AuthLoginSucess) {
                        errorToast(context,
                            error: "Welcome ${state.cred.name}");
                        navigatorKey.currentState!
                            .pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen(cred: state.cred),
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AuthWidgets()
                                .verifyButton(context, isContinue: false),
                          ],
                        );
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthWidgets().continueButton(context, isLogin: true,
                              onPressed: () {
                            if (fkey.currentState!.validate()) {
                              log("form validated..");
                              context.read<AuthCubit>().login(
                                  name: nameCntr.text.trim().toLowerCase(),
                                  mobile: mobileCntr.text.trim());
                            }
                          }),
                        ],
                      );
                    },
                  ),
                  spaceHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Don't have an Account?",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      TextButton(
                          onPressed: () {
                            navigatorKey.currentState!.push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => AuthCubit(),
                                  child: const RegisterScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text("Register"))
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
