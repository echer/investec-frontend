import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/carteira/carteira-view-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageCadastroCarteira extends StatefulWidget {
  static const routeName = '/cadastro/carteira';

  final Carteira carteira;

  PageCadastroCarteira(this.carteira);

  @override
  _PageCadastroCarteira createState() => _PageCadastroCarteira();
}

class _PageCadastroCarteira extends State<PageCadastroCarteira> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CarteiraViewModel viewModel = getIt<CarteiraViewModel>();

    TextEditingController idController =
        TextEditingController(text: widget.carteira.id);
    TextEditingController nomeController =
        TextEditingController(text: widget.carteira.nomeCarteira);
    TextEditingController metaController =
        TextEditingController(text: widget.carteira.metaCarteira?.toString());
    TextEditingController variacaoController =
        TextEditingController(text: widget.carteira.varCarteira?.toString());
    TextEditingController saldoController =
        TextEditingController(text: widget.carteira.saldoCarteira?.toString());
    TextEditingController dtCriacaoController =
        TextEditingController(text: widget.carteira.dtCriacao);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                //Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text('Realizando cadastro aguarde...')));

                Carteira createOrupdate = Carteira(
                    id: idController.text,
                    nomeCarteira: nomeController.text,
                    metaCarteira:
                        double.tryParse(metaController.text)?.toDouble(),
                    varCarteira:
                        double.tryParse(variacaoController.text)?.toDouble(),
                    saldoCarteira:
                        double.tryParse(saldoController.text)?.toDouble(),
                    dtCriacao: dtCriacaoController.text);

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
                Carteira obj = Carteira(id: idController.text);

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
            ? 'Investec - Nova Carteira'
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
                        controller: variacaoController,
                        readOnly: true,
                        enabled: false,
                        decoration:
                            InputDecoration(labelText: 'Variação da Carteira'),
                      ),
                      TextFormField(
                        controller: saldoController,
                        readOnly: true,
                        enabled: false,
                        decoration:
                            InputDecoration(labelText: 'Saldo da Carteira'),
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
