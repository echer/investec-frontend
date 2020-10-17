import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:flutter/material.dart';

import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:provider/provider.dart';

import 'lista-item.dart';
import 'page-cadastro.dart';
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
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    var dialog = DialogUtils(new GlobalKey<State>());
    dialog.showLoadingDialog(context, message: "Carregando dados...");
    await model.list(widget.carteira.id).then(
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
        dialog.hideDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback onCountSelected = () async {
      loadData();
    };
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: Text('Ativos: ${widget.carteira.nomeCarteira}'),
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
                                model.ativos[index],
                                onCountSelected,
                              ),
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
      floatingActionButton: widget.carteira.id == 'all'
          ? Container()
          : FloatingActionButton(
              onPressed: () async {
                Ativo obj = Ativo(
                  carteira: widget.carteira,
                );
                final information = await Navigator.of(context)
                    .pushNamed(PageCadastroAtivo.routeName, arguments: obj);
                if (information != null && information == "refresh") {
                  onCountSelected();
                }
              },
              child: Icon(Icons.add),
            ),
    );
  }
}
