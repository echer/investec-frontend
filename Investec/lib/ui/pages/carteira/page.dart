import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    loading = true;
    model.list().catchError((error) {
      print(error);
      model.notifyListeners();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback onCountSelected = () async {
      await model.list().catchError((error) {
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
        title: Text('Investec - Carteiras'),
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
          Carteira obj =
              Carteira(dtCriacao: DateFormat('dd/MM/yyyy').format(now));
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
