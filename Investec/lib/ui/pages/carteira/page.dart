import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:Investec/ui/utils/DateUtils.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lista-item.dart';
import 'page-cadastro.dart';
import 'view-model.dart';

class PageCarteira extends StatefulWidget {
  static const routeName = '/carteira';

  @override
  _PageCarteira createState() => _PageCarteira();
}

class _PageCarteira extends State<PageCarteira> {
  CarteiraViewModel model = getIt<CarteiraViewModel>();

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
    await model.list().then(
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
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: Text('Carteiras'),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => model,
          child: ChangeNotifierProvider<CarteiraViewModel>(
            create: (context) => model,
            child: Consumer<CarteiraViewModel>(
              builder: (context, value, child) {
                if (loading) {
                  loading = false;
                  return ShimmerList();
                } else {
                  if (model.carteiras.length > 0) {
                    return ListView.builder(
                      itemCount: model.carteiras.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              child: ListaCarteiraItem(
                                model.carteiras[index],
                                onCountSelected,
                              ),
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
          Carteira obj = Carteira(createdOn: DateTime.now().toIso8601String());
          final information = await Navigator.of(context)
              .pushNamed(PageCadastroCarteira.routeName, arguments: obj);
          if (information != null && information == "refresh") {
            onCountSelected();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
