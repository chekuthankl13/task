import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/db/hive_helper.dart';
import 'package:task/db/hive_model/hive_model.dart';
import 'package:task/presentation/splash/splash_screen.dart';
import 'package:task/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  final CredentialModel cred;
  const HomeScreen({required this.cred, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("welcome ${cred.name + cred.lastname}"),
      ),
      body: Column(
        children: [
          tile(txt: "Name", value: cred.name + cred.lastname),
          tile(txt: "Gender", value: cred.gender),
          tile(txt: "nationality", value: cred.nation),
          tile(txt: "Email", value: cred.email),
          tile(txt: "Mobile", value: cred.mobile),
          spaceHeight(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await HiveHelpers().logout();
                    navigatorKey.currentState!.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white),
                  child: const Text("Logout")),
              spaceWidth(10),
              ElevatedButton(
                  onPressed: () async {
                    await HiveHelpers().clearDb();
                    navigatorKey.currentState!.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                        (route) => false);
                  },
                  child: Text("Clear Db")),
            ],
          )
        ],
      ),
    );
  }

  Column tile({required txt, required value}) {
    return Column(
      children: [
        spaceHeight(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("$txt : "), spaceWidth(5), Text(value)],
        ),
      ],
    );
  }
}
