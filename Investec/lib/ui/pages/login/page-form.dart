import 'package:Investec/App.dart';
import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page-cadastro.dart';
import 'view-model.dart';

class LoginPageForm extends StatefulWidget {
  @override
  _LoginPageForm createState() => _LoginPageForm();
}

class _LoginPageForm extends State<LoginPageForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginViewModel model = getIt<LoginViewModel>();

    TextEditingController usuarioController = TextEditingController();
    TextEditingController senhaController = TextEditingController();

    return SafeArea(
      child: FutureBuilder(
        future: Future<bool>.delayed(Duration(milliseconds: 1), () {
          var prefs = getIt<SharedPreferences>();
          if (prefs.getString("username") != null &&
              prefs.getString("username").isNotEmpty) {
            usuarioController.text = prefs.getString("username");
          }
          if (prefs.getString("password") != null &&
              prefs.getString("password").isNotEmpty) {
            senhaController.text = prefs.getString("password");
          }
          return true;
        }),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || !snapshot.data) {
            return CircularProgressIndicator();
          } else {
            return new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  Form(
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
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text('Realizando login aguarde...')));

                                Usuario usuario = Usuario(
                                    email: usuarioController.value.text,
                                    senha: senhaController.value.text);
                                var loginSuccess = await model
                                    .login(usuario)
                                    .catchError((error) {
                                  print(error);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Não foi possível realizar o login: $error')));
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
                                          'Não foi possível realizar o login, usuário ou senha incorretos!')));
                                }
                              }
                            },
                            child: Text('Login'),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                var usuarioCadastrado =
                                    await Navigator.of(context).pushNamed(
                                        PageCadastroUsuario.routeName,
                                        arguments: new Usuario());
                                if (usuarioCadastrado != null) {
                                  Usuario usuario =
                                      usuarioCadastrado as Usuario;
                                  usuarioController.text = usuario.email;
                                  senhaController.text = usuario.senha;
                                }
                              },
                              child: Text('Cadastro'))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
