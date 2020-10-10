import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/ui/pages/ativos/adapter/lista-item.dart';
import 'package:Investec/ui/pages/ativos/page-cadastro.dart';
import 'package:flutter/material.dart';

import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:provider/provider.dart';

import 'view-model.dart';

class PageAtivosCarteira extends StatefulWidget {
  static const routeName = '/carteira/ativos';

  final Carteira carteira;

  PageAtivosCarteira(this.carteira);

  @override
  _PageAtivosCarteira createState() => _PageAtivosCarteira();
}

class _PageAtivosCarteira extends State<PageAtivosCarteira> {
  AtivosViewModel model = getIt<AtivosViewModel>();

  bool loading = false;

  @override
  void initState() {
    loading = true;
    model.list(widget.carteira.id).catchError((error) {
      print(error);
      model.notifyListeners();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback onCountSelected = () async {
      await model.list(widget.carteira.id).catchError((error) {
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
        title: Text('Investec - Ativos: ${widget.carteira.nomeCarteira}'),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => model,
          child: ChangeNotifierProvider<AtivosViewModel>(
            create: (context) => model,
            child: Consumer<AtivosViewModel>(
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
                              child: ListaAtivoItem(
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
          Ativo ativo = new Ativo(carteiraId: widget.carteira.id);
          final information = await Navigator.of(context)
              .pushNamed(PageCadastroAtivo.routeName, arguments: ativo);
          if (information != null && information == "refresh") {
            onCountSelected();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
