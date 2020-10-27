import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/ativos/view-model.dart';
import 'package:Investec/ui/utils/CurrencyPtBrInputFormatter.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:Investec/ui/utils/UpperCaseTextFormatter.dart';
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
    TextEditingController pmController = TextEditingController(
        text: CurrencyPtBrInputFormatter.doubleToStr(widget.obj.pmAtivo));
    TextEditingController qtdController =
        TextEditingController(text: widget.obj.qtdAtivo?.toString());
    TextEditingController stopGainController = TextEditingController(
        text: CurrencyPtBrInputFormatter.doubleToStr(widget.obj.stopGain));
    TextEditingController stopLossController = TextEditingController(
        text: CurrencyPtBrInputFormatter.doubleToStr(widget.obj.stopLoss));
    TextEditingController vlrInvestidoController = TextEditingController(
        text: CurrencyPtBrInputFormatter.doubleToStr(widget.obj.vlrInvestido));
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
                    pmAtivo: CurrencyPtBrInputFormatter.strToDouble(
                        pmController.text),
                    qtdAtivo: double.tryParse(qtdController.text)?.toDouble(),
                    stopGain: CurrencyPtBrInputFormatter.strToDouble(
                        stopGainController.text),
                    stopLoss: CurrencyPtBrInputFormatter.strToDouble(
                        stopLossController.text),
                    ticker: ticketController.text,
                    vlrInvestido: CurrencyPtBrInputFormatter.strToDouble(
                        vlrInvestidoController.text));

                await viewModel
                    .createOrUpdate(widget.obj.carteira.id, createOrupdate)
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
                      Visibility(
                        child: TextFormField(
                          controller: idCarteiraController,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(labelText: 'ID Carteira'),
                        ),
                        visible: false,
                      ),
                      TextFormField(
                        controller: ticketController,
                        decoration: InputDecoration(labelText: 'Ticket'),
                        inputFormatters: [UpperCaseTextFormatter()],
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o Ticket do ativo';
                          }
                          return null;
                        },
                      ),
                      Visibility(
                        child: TextFormField(
                          controller: pmController,
                          decoration: InputDecoration(labelText: 'Preço'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter(maxDigits: 20)
                          ],
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          enabled: false,
                        ),
                        visible: false,
                      ),
                      Visibility(
                        child: TextFormField(
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
                        visible: false,
                      ),
                      Visibility(
                        child: TextFormField(
                          controller: vlrInvestidoController,
                          readOnly: true,
                          enabled: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter(maxDigits: 20)
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Total'),
                        ),
                        visible: false,
                      ),
                      TextFormField(
                        controller: stopLossController,
                        decoration: InputDecoration(labelText: 'Stop Loss'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyPtBrInputFormatter(maxDigits: 20)
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: stopGainController,
                        decoration: InputDecoration(labelText: 'Stop Gain'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyPtBrInputFormatter(maxDigits: 20)
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
