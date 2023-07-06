import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/db/hive_model/hive_model.dart';
import 'package:task/logic/bloc_exports.dart';
import 'package:task/presentation/splash/splash_screen.dart';
import 'package:task/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// disable landscape
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

// hive init
  await Hive.initFlutter();

  Hive.registerAdapter<CredentialModel>(CredentialModelAdapter());

  await Hive.openBox<CredentialModel>("credentials");
  await Hive.openBox<String>("login");

  /// bloc observe state change
  Bloc.observer = MyBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task",
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        primaryColor: Colors.black,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
