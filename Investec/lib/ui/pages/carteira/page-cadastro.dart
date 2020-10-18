import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'view-model.dart';

class PageCadastroCarteira extends StatefulWidget {
  static const routeName = '/cadastro/carteira';

  final Carteira obj;

  PageCadastroCarteira(this.obj);

  @override
  _PageCadastroCarteira createState() => _PageCadastroCarteira();
}

class _PageCadastroCarteira extends State<PageCadastroCarteira> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CarteiraViewModel viewModel = getIt<CarteiraViewModel>();

    TextEditingController idController =
        TextEditingController(text: widget.obj.id);
    TextEditingController nomeController =
        TextEditingController(text: widget.obj.nomeCarteira);
    TextEditingController metaController =
        TextEditingController(text: widget.obj.metaCarteira?.toString());
    TextEditingController dtCriacaoController =
        TextEditingController(text: widget.obj.createdOn);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                var dialog = DialogUtils(new GlobalKey<State>());
                dialog.showLoadingDialog(context,
                    message: "Realizando operação...");

                Carteira createOrupdate = Carteira(
                    id: idController.text,
                    nomeCarteira: nomeController.text,
                    metaCarteira:
                        double.tryParse(metaController.text)?.toDouble(),
                    createdOn: dtCriacaoController.text);

                await viewModel.createOrUpdate(createOrupdate).then((value) {
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

                Carteira obj = Carteira(id: idController.text);

                await viewModel.delete(obj).then((value) {
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
            ? 'Nova Carteira'
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
                            return 'Informe o Nome da carteira';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: metaController,
                        decoration: InputDecoration(labelText: 'Meta'),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}')),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a meta da carteira';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: dtCriacaoController,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Data Criação'),
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
