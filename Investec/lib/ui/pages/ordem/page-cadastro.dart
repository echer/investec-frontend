import 'package:Investec/data/domain/ordem.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/ordem/view-model.dart';
import 'package:flutter/material.dart';

class PageCadastroOrdem extends StatefulWidget {
  static const routeName = '/cadastro/ordem';

  final Ordem obj;

  PageCadastroOrdem(this.obj);

  @override
  _PageCadastroOrdem createState() => _PageCadastroOrdem();
}

class _PageCadastroOrdem extends State<PageCadastroOrdem> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    OrdemViewModel viewModel = getIt<OrdemViewModel>();
    TextEditingController idController =
        TextEditingController(text: widget.obj.id);
    TextEditingController idCarteiraController =
        TextEditingController(text: widget.obj.carteiraId);
    TextEditingController idAtivoController =
        TextEditingController(text: widget.obj.ativoId);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                //Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text('Realizando cadastro aguarde...')));

                Ordem createOrupdate = Ordem(
                  id: idController.text,
                  carteiraId: idCarteiraController.text,
                  ativoId: idAtivoController.text,
                );

                await viewModel.createOrUpdate(createOrupdate).then((value) {
                  Navigator.pop(context, 'refresh');
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
                Ordem obj = Ordem(
                  id: idController.text,
                  carteiraId: idCarteiraController.text,
                  ativoId: idAtivoController.text,
                );
                await viewModel.delete(obj).then((value) {
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
            ? 'Investec - Nova Ordem'
            : 'Investec - Editar: ${idController.text}'),
      ),
      body: SafeArea(
        child: SafeArea(
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
                          controller: idCarteiraController,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(labelText: 'ID Carteira'),
                        ),
                        TextFormField(
                          controller: idCarteiraController,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(labelText: 'ID Ativo'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
