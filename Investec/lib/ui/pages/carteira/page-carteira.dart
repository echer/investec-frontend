import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/carteira/adapter/lista-carteira-item.dart';
import 'package:Investec/ui/pages/carteira/carteira-view-model.dart';
import 'package:Investec/ui/pages/carteira/page-cadastro-carteira.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                              child: ListaCarteiraItem(model.carteiras[index]),
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
          DateTime now = DateTime.now();
          Carteira carteira =
              Carteira(dtCriacao: DateFormat('dd/MM/yyyy').format(now));
          Navigator.of(context)
              .pushNamed(PageCadastroCarteira.routeName, arguments: carteira);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
