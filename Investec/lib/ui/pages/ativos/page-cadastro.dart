import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/ativos/view-model.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageCadastroAtivo extends StatefulWidget {
  static const routeName = '/cadastro/ativo';

  final Ativo obj;

  PageCadastroAtivo(this.obj);

  @override
  _PageCadastroAtivo createState() => _PageCadastroAtivo();
}

class _PageCadastroAtivo extends State<PageCadastroAtivo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AtivosViewModel viewModel = getIt<AtivosViewModel>();
    TextEditingController idController =
        TextEditingController(text: widget.obj.id);
    TextEditingController idCarteiraController =
        TextEditingController(text: widget.obj.carteira.id);
    TextEditingController ticketController =
        TextEditingController(text: widget.obj.ticker);
    TextEditingController pmController =
        TextEditingController(text: widget.obj.pmAtivo?.toString());
    TextEditingController qtdController =
        TextEditingController(text: widget.obj.qtdAtivo?.toString());
    TextEditingController stopGainController =
        TextEditingController(text: widget.obj.stopGain?.toString());
    TextEditingController stopLossController =
        TextEditingController(text: widget.obj.stopLoss?.toString());
    TextEditingController vlrInvestidoController =
        TextEditingController(text: widget.obj.vlrInvestido?.toString());
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

                Ativo createOrupdate = Ativo(
                    id: idController.text,
                    pmAtivo: double.tryParse(pmController.text)?.toDouble(),
                    qtdAtivo: double.tryParse(qtdController.text)?.toDouble(),
                    stopGain:
                        double.tryParse(stopGainController.text)?.toDouble(),
                    stopLoss:
                        double.tryParse(stopLossController.text)?.toDouble(),
                    ticker: ticketController.text,
                    vlrInvestido: double.tryParse(vlrInvestidoController.text)
                        ?.toDouble());

                await viewModel
                    .createOrUpdate(widget.obj.carteira.id, createOrupdate)
                    .then((value) {
                  dialog.hideDialog();
                  Navigator.pop(context, 'refresh');
                }, onError: (e) {
                  print(e);
                  dialog.hideDialog();
                }).catchError((error) {
                  print(error);
                  dialog.hideDialog();
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
                Ativo obj = Ativo(
                  id: idController.text,
                );
                await viewModel.delete(widget.obj.carteira.id, obj).then(
                    (value) {
                  dialog.hideDialog();
                  Navigator.pop(context, 'refresh');
                }, onError: (e) {
                  print(e);
                  dialog.hideDialog();
                }).catchError((error) {
                  print(error);
                  dialog.hideDialog();
                });
              },
            ),
        ],
        title: Text(idController.text.isEmpty
            ? 'Novo Ativo'
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
                        controller: idCarteiraController,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'ID Carteira'),
                      ),
                      TextFormField(
                        controller: ticketController,
                        decoration: InputDecoration(labelText: 'Ticket'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o Ticket do ativo';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: pmController,
                        decoration: InputDecoration(labelText: 'Preço'),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}')),
                        ],
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        enabled: false,
                      ),
                      TextFormField(
                        controller: qtdController,
                        decoration: InputDecoration(labelText: 'Quantidade'),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}')),
                        ],
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        enabled: false,
                      ),
                      TextFormField(
                        controller: vlrInvestidoController,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Total'),
                      ),
                      TextFormField(
                        controller: stopLossController,
                        decoration: InputDecoration(labelText: 'Stop Loss'),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}')),
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: stopGainController,
                        decoration: InputDecoration(labelText: 'Stop Gain'),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}')),
                        ],
                        keyboardType: TextInputType.number,
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
