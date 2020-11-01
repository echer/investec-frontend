import 'package:Investec/LoginApp.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/domain/carteiraprecovm.dart';
import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/ativos/page.dart';
import 'package:Investec/ui/pages/carteira/page.dart';
import 'package:Investec/ui/pages/carteira/view-model.dart';
import 'package:Investec/ui/pages/grafico-carteira/grafico-pizza-carteira.dart';
import 'package:Investec/ui/pages/login/page-cadastro.dart';
import 'package:Investec/ui/pages/shimmer/lista-shimmer.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageHome extends StatefulWidget {
  static const routeName = '/';
  final Usuario usuario;

  const PageHome(this.usuario);

  @override
  _PageHome createState() => _PageHome();
}

class _PageHome extends State<PageHome> {
  CarteiraViewModel model = getIt<CarteiraViewModel>();

  bool loading = false;
  Usuario usuarioUpdated;

  _PageHome() {
    usuarioUpdated = widget.usuario;
  }

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

    SharedPreferences prefs = getIt<SharedPreferences>();

    var userAccountDrawer = UserAccountsDrawerHeader(
      accountName: Text("${usuarioUpdated.nome}"),
      accountEmail: Text("${usuarioUpdated.email}"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(
          "${usuarioUpdated.nome.substring(0, 1).toUpperCase()}",
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
    var hasProfileImage = false;
    if (hasProfileImage) {
      userAccountDrawer = UserAccountsDrawerHeader(
        accountName: Text("${usuarioUpdated.nome}"),
        accountEmail: Text("${usuarioUpdated.email}"),
        currentAccountPicture: new CircleAvatar(
          backgroundImage:
              NetworkImage("http://tineye.com/images/widgets/mona.jpg"),
        ),
      );
    }
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
        title: Text('Desempenho Carteira'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            userAccountDrawer,
            ExpansionTile(
              initiallyExpanded: true,
              title: Text("Meus Cadastros"),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.account_balance_wallet_outlined),
                  title: Text('Minhas Carteiras'),
                  onTap: () =>
                      {Navigator.of(context).pushNamed(PageCarteira.routeName)},
                ),
                ListTile(
                  leading: Icon(Icons.attach_money_outlined),
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
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text("Meu Desempenho"),
              children: <Widget>[],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text("Minha Conta"),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text('Editar Perfil'),
                  onTap: () async {
                    var usuarioAtualizado = await Navigator.of(context)
                        .pushNamed(PageCadastroUsuario.routeName,
                            arguments: usuarioUpdated);
                    if (usuarioAtualizado != null) {
                      usuarioUpdated = usuarioAtualizado;
                      Phoenix.rebirth(context);
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () async {
                    prefs.setString("logged", "");
                    prefs.setString("token", "");
                    runApp(
                      Phoenix(
                        child: LoginApp(),
                      ),
                    );
                  },
                ),
              ],
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
