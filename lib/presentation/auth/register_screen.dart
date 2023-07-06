import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/logic/bloc_exports.dart';
import 'package:task/presentation/auth/widgets/widget.dart';
import 'package:task/presentation/home/home_screen.dart';
import 'package:task/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameCntr = TextEditingController();
  TextEditingController lastnameCntr = TextEditingController();
  TextEditingController mobileCntr = TextEditingController();
  TextEditingController emailCntr = TextEditingController();

  GlobalKey<FormState> fkey = GlobalKey<FormState>();
  ValueNotifier<String?> selectedGender = ValueNotifier(null);

  ValueNotifier<String?> selectedNationality = ValueNotifier(null);

  List<String> nationalities = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'China',
    'India',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: fkey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15),
          children: [
            spaceHeight(30),
            const Text(
              'Register User',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            spaceHeight(40),
            AuthWidgets().field(
                cntr: nameCntr, txt: "First Name", ic: CupertinoIcons.person),
            spaceHeight(20),
            AuthWidgets().field(
                cntr: lastnameCntr,
                txt: "Last Name",
                ic: CupertinoIcons.person),
            spaceHeight(20),
            const Text(
              'Select Gender',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            ValueListenableBuilder(
              valueListenable: selectedGender,
              builder: (context, value, child) => Row(
                children: [
                  Radio(
                    value: 'male',
                    groupValue: value,
                    activeColor: Colors.black,
                    onChanged: (valu) {
                      selectedGender.value = valu;
                    },
                  ),
                  const Text(
                    'Male',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  Radio(
                    value: 'female',
                    groupValue: value,
                    activeColor: Colors.black,
                    onChanged: (valu) {
                      selectedGender.value = valu;
                    },
                  ),
                  const Text(
                    'Female',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  Radio(
                    value: 'Trangender',
                    groupValue: value,
                    activeColor: Colors.black,
                    onChanged: (valu) {
                      selectedGender.value = valu;
                    },
                  ),
                  const Text(
                    'Trangender',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            spaceHeight(20),
            ValueListenableBuilder(
              valueListenable: selectedNationality,
              builder: (context, value, child) =>
                  DropdownButtonFormField<String>(
                value: selectedNationality.value,
                onChanged: (newValue) {
                  selectedNationality.value = newValue;
                },
                items: nationalities.map((nationality) {
                  return DropdownMenuItem<String>(
                    value: nationality,
                    child: Text(nationality),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Nationality',
                  labelStyle: const TextStyle(fontSize: 11, color: Colors.grey),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[200]!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            spaceHeight(20),
            AuthWidgets()
                .field(cntr: emailCntr, txt: "Email", ic: CupertinoIcons.mail),
            spaceHeight(20),
            AuthWidgets().field(
              cntr: mobileCntr,
              isNumber: true,
              txt: "Mobile no",
              ic: CupertinoIcons.phone,
            ),
            spaceHeight(50),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoadError) {
                  errorToast(context, error: state.error);
                }
                if (state is AuthRegisterSucess) {
                  errorToast(context, error: "Welcome ${state.cred.name}");
                  navigatorKey.currentState!.pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(cred: state.cred),
                    ),
                    (route) => false,
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthWidgets().verifyButton(context, isContinue: false),
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthWidgets().continueButton(context, onPressed: () {
                      if (fkey.currentState!.validate()) {
                        log("form validated..");
                        context.read<AuthCubit>().register(
                            email: emailCntr.text.trim(),
                            gender: selectedGender.value,
                            lastname: lastnameCntr.text.trim(),
                            mobile: mobileCntr.text.trim(),
                            name: nameCntr.text.trim(),
                            nationality: selectedNationality.value);
                      }
                    }),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
