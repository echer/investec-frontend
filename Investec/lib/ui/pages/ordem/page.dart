import 'package:Investec/data/domain/ativoprecovm.dart';
import 'package:Investec/data/domain/ordem.dart';
import 'package:Investec/ui/custom/fancy-fab.dart';
import 'package:Investec/ui/utils/DateUtils.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:provider/provider.dart';

import 'lista-item.dart';
import 'page-cadastro.dart';
import 'view-model.dart';

class PageOrdensAtivo extends StatefulWidget {
  static const routeName = '/carteira/ativos/ordens';

  final AtivoPrecoVM model;

  PageOrdensAtivo(this.model);

  @override
  _PageOrdensAtivo createState() => _PageOrdensAtivo();
}

class _PageOrdensAtivo extends State<PageOrdensAtivo> {
  OrdemViewModel model = getIt<OrdemViewModel>();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadData(false);
  }

  Future<void> loadData(bool showDialog) async {
    loading = true;
    var dialog;
    if (showDialog) {
      dialog = DialogUtils(new GlobalKey<State>());
      dialog.showLoadingDialog(context, message: "Carregando dados...");
    }
    await model
        .list(widget.model.ativo.carteira.id, widget.model.ativo.id)
        .then(
      (value) {},
      onError: (error) {
        DialogUtils(new GlobalKey<State>())
            .showAlertDialog(context, "Atenção", "Ocorreu um erro: $error");
      },
    ).catchError((error) {
      DialogUtils(new GlobalKey<State>())
          .showAlertDialog(context, "Atenção", "Ocorreu um erro: $error");
    }).whenComplete(
      () {
        loading = false;
        model.notify();
        if (showDialog) {
          dialog.hideDialog();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback onCountSelected = () async {
      loadData(true);
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordens: ${widget.model.ativo.ticker}'),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => model,
          child: ChangeNotifierProvider<OrdemViewModel>(
            create: (context) => model,
            child: Consumer<OrdemViewModel>(
              builder: (context, value, child) {
                if (loading) {
                  loading = false;
                  return ShimmerList();
                } else {
                  if (model.ativos.length > 0) {
                    return ListView.builder(
                      itemCount: model.ativos.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              child: ListaOrdemItem(
                                  model.ativos[index], onCountSelected),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('Nenhum resultado encontrado!'),
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FancyFab(
        <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              onPressed: () async {
                Ordem obj = new Ordem(
                  ativosCarteira: widget.model.ativo,
                  tipoOrdem: 0,
                  createdOn: DateTime.now().toIso8601String(),
                );
                final information = await Navigator.of(context)
                    .pushNamed(PageCadastroOrdem.routeName, arguments: obj);
                if (information != null && information == "refresh") {
                  onCountSelected();
                }
              },
              tooltip: 'Comprar',
              heroTag: null,
              child: Icon(Icons.add),
            ),
          ),
          Container(
            child: FloatingActionButton(
              onPressed: () async {
                Ordem obj = new Ordem(
                  ativosCarteira: widget.model.ativo,
                  tipoOrdem: 1,
                  createdOn: DateTime.now().toIso8601String(),
                );
                final information = await Navigator.of(context)
                    .pushNamed(PageCadastroOrdem.routeName, arguments: obj);
                if (information != null && information == "refresh") {
                  onCountSelected();
                }
              },
              tooltip: 'Vender',
              heroTag: null,
              child: Icon(
                Icons.remove,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
