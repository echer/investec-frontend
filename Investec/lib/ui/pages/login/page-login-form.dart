import 'package:Investec/App.dart';
import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/login/login-view-model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageForm extends StatefulWidget {
  @override
  _LoginPageForm createState() => _LoginPageForm();
}

class _LoginPageForm extends State<LoginPageForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginViewModel model = serviceLocator<LoginViewModel>();

    TextEditingController usuarioController = TextEditingController();
    TextEditingController senhaController = TextEditingController();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: usuarioController,
              decoration: InputDecoration(labelText: 'Usuário'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Informe o Usuário';
                }
                return null;
              },
            ),
            TextFormField(
              controller: senhaController,
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
              onPressed: () async {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Realizando login aguarde...')));

                  Usuario usuario = Usuario(
                      email: usuarioController.value.text,
                      senha: senhaController.value.text);
                  var loginSuccess =
                      await model.login(usuario).catchError((error) => {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Não foi possível realizar login: $error')))
                          });
                  if (loginSuccess != null &&
                      loginSuccess.token != null &&
                      loginSuccess.token.isNotEmpty) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("logged", "S");
                    prefs.setString("token", loginSuccess.token);
                    runApp(App());
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Não foi possível realizar login, usuário ou senha incorretos!')));
                  }
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
