import 'dart:async';

import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/login/login-view-model.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App.dart';
import 'LoginApp.dart';
import 'ui/pages/carteira/carteira-view-model.dart';

Future<void> main() async {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting(Intl.defaultLocale);

  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection();

  return runZonedGuarded(() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("logged") ||
        prefs.getString("logged").isEmpty ||
        !prefs.containsKey("token") ||
        prefs.getString("token").isEmpty) {
      runApp(LoginApp());
      return;
    }
    var valid = await validKey(prefs.getString("token"));
    if (!valid) {
      runApp(LoginApp());
      return;
    }
    runApp(App());
    return;
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<bool> validKey(String token) async {
  if (token.isEmpty) return false;
  await getIt<CarteiraViewModel>().list().catchError((error) {
    return false;
  });
  return true;
}
