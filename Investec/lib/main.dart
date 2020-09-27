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
      prefs.getString("logged").isNotEmpty ||
      !await validKey()) {
    runApp(LoginApp());
  } else {
    runApp(App());
  }
}

Future<bool> validKey() async {
  return true;
}
