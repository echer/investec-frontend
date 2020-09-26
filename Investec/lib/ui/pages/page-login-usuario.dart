import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
    Widget build(BuildContext context) {
    return Scafold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/investec-logo.jpg"),
            fit: BoxFit.cover
          )
        ),
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

          ],
        )
      )
    )
  }
}