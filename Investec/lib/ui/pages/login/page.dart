import 'package:flutter/material.dart';

import 'page-form.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/usuarios';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image(
                  image: AssetImage('images/investec-logo.jpeg'),
                  fit: BoxFit.fill, // use this
                ),
              ),
              LoginPageForm()
            ],
          ),
        ),
      ),
    );
  }
}
