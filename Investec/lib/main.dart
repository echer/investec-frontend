import 'package:Investec/data/service/service-locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App.dart';
import 'LoginApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setupServiceLocator();
  if (!prefs.containsKey("logged") ||
      prefs.getString("logged").isEmpty ||
      !prefs.containsKey("token") ||
      prefs.getString("token").isEmpty ||
      !await validKey(prefs.getString("token"))) {
    runApp(LoginApp());
  } else {
    runApp(App());
  }
}

Future<bool> validKey(String token) async {
  return true;
}
