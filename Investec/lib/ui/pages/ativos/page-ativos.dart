import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/ui/pages/ativos/adapter/lista-ativo-item.dart';
import 'package:Investec/ui/pages/ativos/page-cadastro-ativo.dart';
import 'package:flutter/material.dart';

import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:provider/provider.dart';

import 'ativos-view-model.dart';

class PageAtivosCarteira extends StatefulWidget {
  static const routeName = '/carteira/ativos';

  final Carteira carteira;

  PageAtivosCarteira(this.carteira);

  @override
  _PageAtivosCarteira createState() => _PageAtivosCarteira();
}

class _PageAtivosCarteira extends State<PageAtivosCarteira> {
  AtivosViewModel model = serviceLocator<AtivosViewModel>();

  bool loading = false;

  @override
  void initState() {
    loading = true;
    model.list(widget.carteira.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          create: (context) => AtivosViewModel(),
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
                              child: ListaAtivoItem(model.ativos[index]),
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
        onPressed: () {
          Navigator.of(context).pushNamed(PageCadastroAtivo.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
