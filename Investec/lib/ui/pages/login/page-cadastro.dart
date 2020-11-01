import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view-model.dart';

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
    SharedPreferences prefs = getIt<SharedPreferences>();

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

                var dialog = DialogUtils(new GlobalKey<State>());
                dialog.showLoadingDialog(context,
                    message: "Realizando operação...");

                await viewModel.createOrUpdate(createOrupdate).then((value) {
                  dialog.hideDialog();
                  prefs.setString("username", createOrupdate.email);
                  prefs.setString("password", createOrupdate.senha);
                  Navigator.pop(context, createOrupdate);
                }, onError: (error) {
                  dialog.hideDialog();
                  DialogUtils(new GlobalKey<State>()).showAlertDialog(
                      context, "Atenção", "Ocorreu um erro: $error");
                }).catchError((error) {
                  dialog.hideDialog();
                  DialogUtils(new GlobalKey<State>()).showAlertDialog(
                      context, "Atenção", "Ocorreu um erro: $error");
                });
              }
            },
          ),
          if (idController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                var dialog = DialogUtils(new GlobalKey<State>());
                dialog.showLoadingDialog(context,
                    message: "Realizando operação...");

                await viewModel.delete().then((value) {
                  dialog.hideDialog();
                  Navigator.pop(context, 'refresh');
                }, onError: (error) {
                  dialog.hideDialog();
                  DialogUtils(new GlobalKey<State>()).showAlertDialog(
                      context, "Atenção", "Ocorreu um erro: $error");
                }).catchError((error) {
                  dialog.hideDialog();
                  DialogUtils(new GlobalKey<State>()).showAlertDialog(
                      context, "Atenção", "Ocorreu um erro: $error");
                });
              },
            ),
        ],
        title: Text(idController.text.isEmpty
            ? 'Novo Usuário'
            : 'Editar: ${idController.text}'),
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
                        readOnly: idController.text.isNotEmpty,
                        enabled: idController.text.isEmpty,
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
                        readOnly: idController.text.isNotEmpty,
                        enabled: idController.text.isEmpty,
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
