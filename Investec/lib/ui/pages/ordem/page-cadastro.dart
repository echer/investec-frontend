import 'package:Investec/data/domain/ordem.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/ordem/view-model.dart';
import 'package:Investec/ui/utils/CurrencyPtBrInputFormatter.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
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
    TextEditingController idCarteiraController = TextEditingController(
        text: widget.obj.ativosCarteira != null &&
                widget.obj.ativosCarteira.carteira != null
            ? widget.obj.ativosCarteira.carteira.id
            : "");
    TextEditingController idAtivoController = TextEditingController(
        text: widget.obj.ativosCarteira != null
            ? widget.obj.ativosCarteira.id
            : "");
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
        text: widget.obj.vlrOrdem != null
            ? CurrencyPtBrInputFormatter.doubleToStr(widget.obj.vlrOrdem)
            : "R\$ 0.00");
    TextEditingController taxaOrdemController = TextEditingController(
        text: widget.obj.taxaOrdem != null
            ? CurrencyPtBrInputFormatter.doubleToStr(widget.obj.taxaOrdem)
            : "R\$ 0.00");
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

                Ordem create = Ordem(
                  id: idController.text,
                  dtOrdem: dtOrdemController.text,
                  qtdOrdem: int.tryParse(qtdOrdemController.text)?.toInt(),
                  taxaOrdem: CurrencyPtBrInputFormatter.strToDouble(
                      taxaOrdemController.text),
                  tipoOrdem: int.tryParse(tipoOrdemController.text)?.toInt(),
                  vlrOrdem: CurrencyPtBrInputFormatter.strToDouble(
                      vlrOrdemController.text),
                );

                await viewModel
                    .create(widget.obj.ativosCarteira.carteira.id,
                        widget.obj.ativosCarteira.id, create)
                    .then((value) {
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
        ],
        title: Text(idController.text.isEmpty
            ? 'Nova Ordem'
            : 'Editar: ${idController.text}'),
      ),
      body: FutureBuilder(
        future: Future<bool>.delayed(Duration(milliseconds: 1), () async {
          return true;
        }),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || !snapshot.data) {
            return CircularProgressIndicator();
          } else {
            return SafeArea(
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
                              Visibility(
                                child: TextFormField(
                                  controller: idCarteiraController,
                                  readOnly: true,
                                  enabled: false,
                                  decoration:
                                      InputDecoration(labelText: 'ID Carteira'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Informe o ID Carteira';
                                    }
                                    return null;
                                  },
                                ),
                                visible: false,
                              ),
                              Visibility(
                                child: TextFormField(
                                  controller: idAtivoController,
                                  readOnly: true,
                                  enabled: false,
                                  decoration:
                                      InputDecoration(labelText: 'ID Ativo'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Informe o ID Ativo';
                                    }
                                    return null;
                                  },
                                ),
                                visible: false,
                              ),
                              Visibility(
                                child: TextFormField(
                                  controller: tipoOrdemController,
                                  readOnly: true,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText:
                                          'Tipo: 0 = COMPRA / 1 = VENDA'),
                                  maxLength: 1,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Informe o Tipo';
                                    }
                                    return null;
                                  },
                                ),
                                visible: false,
                              ),
                              TextFormField(
                                controller: qtdOrdemController,
                                decoration:
                                    InputDecoration(labelText: 'Quantidade'),
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
                                decoration: InputDecoration(
                                    labelText: 'Valor Unitário'),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CurrencyPtBrInputFormatter(maxDigits: 20)
                                ],
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Informe o Valor Unitário';
                                  }
                                  if (CurrencyPtBrInputFormatter.strToDouble(
                                          value) <=
                                      0) {
                                    return "Informe um Valor válido!";
                                  }

                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: taxaOrdemController,
                                decoration: InputDecoration(labelText: 'Taxa'),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CurrencyPtBrInputFormatter(maxDigits: 20)
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
            );
          }
        },
      ),
    );
  }
}
