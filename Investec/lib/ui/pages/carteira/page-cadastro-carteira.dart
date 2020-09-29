import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/carteira/carteira-view-model.dart';
import 'package:Investec/ui/pages/utils/decimal-input-format.dart';
import 'package:flutter/material.dart';

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

    TextEditingController idController = TextEditingController();
    TextEditingController nomeController = TextEditingController();
    TextEditingController metaController = TextEditingController();
    TextEditingController variacaoController = TextEditingController();
    TextEditingController saldoController = TextEditingController();
    TextEditingController dtCriacaoController = TextEditingController();

    if (widget.carteira.id != null) idController.text = widget.carteira.id;

    if (widget.carteira.nomeCarteira != null)
      nomeController.text = widget.carteira.nomeCarteira;

    if (widget.carteira.metaCarteira != null)
      metaController.text = widget.carteira.metaCarteira.toString();

    if (widget.carteira.varCarteira != null)
      variacaoController.text = widget.carteira.varCarteira.toString();
    else
      variacaoController.text = "0";

    if (widget.carteira.saldoCarteira != null)
      saldoController.text = widget.carteira.saldoCarteira.toString();
    else
      saldoController.text = "0";

    if (widget.carteira.dtCriacao != null)
      dtCriacaoController.text = widget.carteira.dtCriacao;

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

                await viewModel
                    .createOrUpdate(createOrupdate)
                    .catchError((error) {
                  print(error);
                  //Scaffold.of(context).showSnackBar(SnackBar(
                  //   content: Text(
                  //      'Não foi possível salvar a carteira: $error')))
                }).then((value) {
                  Navigator.pop(context, 'refresh');
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => {},
          ),
        ],
        title: Text(idController.text.isEmpty
            ? 'Investec - Nova Carteira'
            : 'Investec - Editar: ${widget.carteira.id}'),
      ),
      body: SafeArea(
        child: Form(
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
                  inputFormatters: [DecimalTextInputFormatter()],
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
                  decoration: InputDecoration(labelText: 'Saldo da Carteira'),
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
      ),
    );
  }
}
