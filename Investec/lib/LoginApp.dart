import 'package:flutter/material.dart';

import 'ui/pages/login/page-login-usuario.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.red,
        primaryColor: Colors.red,
        primaryColorDark: Colors.red,
        primaryColorLight: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
