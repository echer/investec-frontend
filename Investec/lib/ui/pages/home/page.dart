import 'package:Investec/LoginApp.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/domain/carteiraprecovm.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/ativos/page.dart';
import 'package:Investec/ui/pages/carteira/page.dart';
import 'package:Investec/ui/pages/carteira/view-model.dart';
import 'package:Investec/ui/pages/home/grafico-pizza-carteira.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageHome extends StatefulWidget {
  static const routeName = '/';

  @override
  _PageHome createState() => _PageHome();
}

class _PageHome extends State<PageHome> {
  CarteiraViewModel model = getIt<CarteiraViewModel>();

  bool loading = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    loading = true;
    var dialog = DialogUtils(new GlobalKey<State>());
    dialog.showLoadingDialog(context, message: "Carregando dados...");
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
        dialog.hideDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback onCountSelected = () async {
      loadData();
    };

    SharedPreferences prefs = getIt<SharedPreferences>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              onCountSelected();
            },
          ),
        ],
        title: Text('Investec - Home Page'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text('Investec'),
            ),
            ListTile(
              leading: Icon(Icons.money_off),
              title: Text('Minhas Carteiras'),
              onTap: () =>
                  {Navigator.of(context).pushNamed(PageCarteira.routeName)},
            ),
            ListTile(
              leading: Icon(Icons.money_off),
              title: Text('Minhas Ações'),
              onTap: () => {
                Navigator.of(context).pushNamed(
                  PageAtivosCarteira.routeName,
                  arguments: CarteiraPrecoVM(
                    carteira: Carteira(
                      id: 'all',
                      nomeCarteira: 'Todas',
                    ),
                  ),
                ),
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                prefs.setString("logged", "");
                prefs.setString("token", "");
                runApp(LoginApp());
              },
            ),
          ],
        ),
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
                    return Container(
                      margin: const EdgeInsets.all(5),
                      child: Card(
                        child: GraficoPizzaCarteira.newInstance(
                          model.carteiras
                              .where((element) => element.vlrInvestido > 0)
                              .toList(),
                        ),
                      ),
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
    );
  }
}
