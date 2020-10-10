import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/login/view-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageCadastroUsuario extends StatefulWidget {
  static const routeName = '/cadastro/usuario';

  final Usuario usuario;

  PageCadastroUsuario(this.usuario);

  @override
  _PageCadastroUsuario createState() => _PageCadastroUsuario();
}

class _PageCadastroUsuario extends State<PageCadastroUsuario> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = getIt<LoginViewModel>();

    TextEditingController idController =
        TextEditingController(text: widget.usuario.id);
    TextEditingController nomeController =
        TextEditingController(text: widget.usuario.nome);
    TextEditingController cpfController =
        TextEditingController(text: widget.usuario.cpf);
    TextEditingController emailController =
        TextEditingController(text: widget.usuario.email);
    TextEditingController senhaController =
        TextEditingController(text: widget.usuario.senha);
    TextEditingController foneController =
        TextEditingController(text: widget.usuario.fone);
    TextEditingController dtNascimentoController =
        TextEditingController(text: widget.usuario.dtNascimento);
    TextEditingController perfilController = TextEditingController(
        text: widget.usuario.perfilInvestidor != null
            ? widget.usuario.perfilInvestidor.toString()
            : "");

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                //Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text('Realizando cadastro aguarde...')));

                Usuario createOrupdate = Usuario(
                    id: idController.text,
                    nome: nomeController.text,
                    email: emailController.text,
                    cpf: cpfController.text,
                    senha: senhaController.text,
                    fone: foneController.text,
                    dtNascimento: dtNascimentoController.text,
                    perfilInvestidor:
                        int.tryParse(perfilController.text)?.toInt());

                await viewModel.createOrUpdate(createOrupdate).then((value) {
                  var pref = getIt<SharedPreferences>();
                  pref.setString("username", createOrupdate.email);
                  pref.setString("password", createOrupdate.senha);
                  Navigator.pop(context, createOrupdate);
                }, onError: (e) {
                  print(e);
                }).catchError((error) {
                  print(error);
                });
              }
            },
          ),
          if (idController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await viewModel.delete().then((value) {
                  Navigator.pop(context, 'refresh');
                }, onError: (e) {
                  print(e);
                }).catchError((error) {
                  print(error);
                });
              },
            ),
        ],
        title: Text(idController.text.isEmpty
            ? 'Investec - Novo Usuário'
            : 'Investec - Editar: ${idController.text}'),
      ),
      body: SafeArea(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: idController,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'ID'),
                      ),
                      TextFormField(
                        controller: nomeController,
                        decoration: InputDecoration(labelText: 'Nome'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o Nome do Usuário';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cpfController,
                        decoration: InputDecoration(labelText: 'CPF'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o CPF do Usuário';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'E-mail'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o E-mail do Usuário';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: foneController,
                        decoration: InputDecoration(labelText: 'Telefone'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o Telefone do Usuário';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: dtNascimentoController,
                        decoration:
                            InputDecoration(labelText: 'Data de Nascimento'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a Data de Nascimento do Usuário';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: perfilController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration:
                            InputDecoration(labelText: 'Perfil do Investidor'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o Perfil do Investidor Usuário';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: senhaController,
                        decoration: InputDecoration(labelText: 'Senha'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a Senha do Usuário';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
