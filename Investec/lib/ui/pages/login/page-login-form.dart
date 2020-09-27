import 'package:flutter/material.dart';

class LoginPageForm extends StatefulWidget {
  @override
  _LoginPageForm createState() => _LoginPageForm();
}

class _LoginPageForm extends State<LoginPageForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Usuário'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Informe o Usuário';
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Senha'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Informe a senha';
                }
                return null;
              },
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Realizando Login')));
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
