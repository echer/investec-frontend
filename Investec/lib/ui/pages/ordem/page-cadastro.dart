import 'package:Investec/data/domain/ordem.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/ordem/view-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    TextEditingController tipoOrdemController = TextEditingController(
        text: widget.obj.tipoOrdem != null
            ? widget.obj.tipoOrdem.toString()
            : "");
    TextEditingController dtOrdemController = TextEditingController(
        text: widget.obj.dtOrdem != null ? widget.obj.dtOrdem : "");
    TextEditingController qtdOrdemController = TextEditingController(
        text:
            widget.obj.qtdOrdem != null ? widget.obj.qtdOrdem.toString() : "");
    TextEditingController vlrOrdemController = TextEditingController(
        text:
            widget.obj.vlrOrdem != null ? widget.obj.vlrOrdem.toString() : "");
    TextEditingController taxaOrdemController = TextEditingController(
        text: widget.obj.taxaOrdem != null
            ? widget.obj.taxaOrdem.toString()
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o ID Carteira';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: idCarteiraController,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(labelText: 'ID Ativo'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o ID Ativo';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: tipoOrdemController,
                          decoration: InputDecoration(
                              labelText: 'Tipo: 0 = COMPRA / 1 = VENDA'),
                          maxLength: 1,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o Tipo';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: qtdOrdemController,
                          decoration: InputDecoration(labelText: 'Quantidade'),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?')),
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe a quantidade';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: vlrOrdemController,
                          decoration: InputDecoration(labelText: 'Valor'),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}')),
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o Valor';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: taxaOrdemController,
                          decoration: InputDecoration(labelText: 'Taxa'),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}')),
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe a taxa';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: dtOrdemController,
                          decoration: InputDecoration(labelText: 'Data'),
                          readOnly: true,
                          enabled: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe a data';
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
      ),
    );
  }
}
