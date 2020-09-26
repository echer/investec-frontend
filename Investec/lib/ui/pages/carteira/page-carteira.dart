import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/carteira/adapter/lista-carteira-item.dart';
import 'package:Investec/ui/pages/carteira/carteira-view-model.dart';
import 'package:Investec/ui/pages/carteira/page-cadastro-carteira.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageCarteira extends StatefulWidget {
  static const routeName = '/carteira';

  @override
  _PageCarteira createState() => _PageCarteira();
}

class _PageCarteira extends State<PageCarteira> {
  CarteiraViewModel model = serviceLocator<CarteiraViewModel>();

  bool loading = false;

  @override
  void initState() {
    loading = true;
    model.list();
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
          create: (context) => CarteiraViewModel(),
          child: ChangeNotifierProvider<CarteiraViewModel>(
            create: (context) => model,
            child: Consumer<CarteiraViewModel>(
              builder: (context, value, child) {
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
                  var result = Center(
                    child: Text(loading
                        ? 'Aguarde carregando...'
                        : 'Nenhum resultado encontrado'),
                  );
                  if (loading) loading = false;
                  return result;
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(PageCadastroCarteira.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
