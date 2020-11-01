import 'dart:async';
import 'dart:io';

import 'package:Investec/data/service/service-locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App.dart';
import 'LoginApp.dart';
import 'data/domain/usuario.dart';
import 'ui/pages/carteira/view-model.dart';
import 'ui/pages/login/view-model.dart';

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
        prefs.getString("token").isEmpty ||
        !prefs.containsKey("usuario") ||
        prefs.getString("usuario").isEmpty ||
        !prefs.containsKey("senha") ||
        prefs.getString("senha").isEmpty) {
      runApp(
        Phoenix(
          child: LoginApp(),
        ),
      );
      return;
    }
    var valid = await validKey(prefs.getString("token"));
    if (!valid) {
      runApp(
        Phoenix(
          child: LoginApp(),
        ),
      );
      return;
    }

    LoginViewModel model = getIt<LoginViewModel>();

    Usuario usuario = Usuario(
      email: prefs.getString("username"),
      senha: prefs.getString("password"),
    );
    await model.login(usuario).then(
      (loginSuccess) {
        runApp(
          Phoenix(
            child: App(
              loginSuccess.usuario,
            ),
          ),
        );
      },
      onError: (error) {
        print(error);
        exit(0);
      },
    ).catchError((error) {
      print(error);
      exit(0);
    });

    return;
  }, (error, stack) {
    print(stack);
    print(error);
    exit(0);
  });
}

Future<bool> validKey(String token) async {
  if (token.isEmpty) return false;
  await getIt<CarteiraViewModel>().list().catchError((error) {
    return false;
  });
  return true;
}
