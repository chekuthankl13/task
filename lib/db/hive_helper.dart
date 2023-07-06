import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/db/hive_model/hive_model.dart';

class HiveHelpers {
  static const credentials = 'credentials';

  static const login = 'login';

  static Box<CredentialModel> credBox = Hive.box(credentials);

  static Box<String> loginBox = Hive.box(login);

  /// register setup

  registerUser({required CredentialModel credentialModel}) async {
    await credBox.put(credentialModel.mobile, credentialModel);
    await loginBox.add("true");
    log("user created ....");
  }

  loginUser({required mobile, required name}) async {
    if (credBox.containsKey(mobile)) {
      log("true");
      return true;
    } else {
      return false;
    }
  }

  CredentialModel getUser({required mobile}) {
    return credBox.get(mobile)!;
  }

  clearDb() async {
    await credBox.clear();
    await loginBox.clear();
  }

  logout() async {
    await loginBox.clear();
  }
}
