import 'package:Investec/LoginApp.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/domain/carteiraprecovm.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/pages/ativos/page.dart';
import 'package:Investec/ui/pages/carteira/page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageHome extends StatelessWidget {
  static const routeName = '/';

  PageHome();

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = getIt<SharedPreferences>();
    return Scaffold(
      appBar: AppBar(
        actions: [],
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
                  )),
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
          child: Center(
        child: Text('Hello Investec'),
      )),
    );
  }
}
