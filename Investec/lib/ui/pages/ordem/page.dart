import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/domain/ordem.dart';
import 'package:flutter/material.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:provider/provider.dart';

import 'lista-item.dart';
import 'page-cadastro.dart';
import 'view-model.dart';

class PageOrdensAtivo extends StatefulWidget {
  static const routeName = '/carteira/ativos/ordens';

  final Ativo model;

  PageOrdensAtivo(this.model);

  @override
  _PageOrdensAtivo createState() => _PageOrdensAtivo();
}

class _PageOrdensAtivo extends State<PageOrdensAtivo> {
  OrdemViewModel model = getIt<OrdemViewModel>();

  bool loading = false;

  @override
  void initState() {
    loading = true;
    model.list(widget.model.carteira.id, widget.model.id).catchError((error) {
      print(error);
      model.notifyListeners();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback onCountSelected = () async {
      await model
          .list(widget.model.carteira.id, widget.model.id)
          .catchError((error) {
        print(error);
        model.notifyListeners();
      });
    };
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: Text('Ordens: ${widget.model.ticker}'),
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
                            Divider(
                              color: Colors.grey,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DateTime now = DateTime.now();
          Ordem obj = new Ordem(
            ativosCarteira: widget.model,
            dtOrdem: now.toIso8601String(),
          );
          final information = await Navigator.of(context)
              .pushNamed(PageCadastroOrdem.routeName, arguments: obj);
          if (information != null && information == "refresh") {
            onCountSelected();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
