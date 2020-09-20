import 'package:Investec/ui/pages/page-cadastro-ativo.dart';
import 'package:Investec/ui/pages/page-carteira-ativos.dart';
import 'package:Investec/ui/pages/page-cadastro-carteira.dart';
import 'package:Investec/ui/pages/page-carteira.dart';
import 'package:Investec/ui/pages/page-home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routes = {
      PageHome.routeName: (context) => PageHome(),
      PageCarteira.routeName: (context) => PageCarteira(),
      PageCadastroCarteira.routeName: (context) => PageCadastroCarteira(),
      PageCadastroAtivo.routeName: (context) => PageCadastroAtivo(),
      PageAtivosCarteira.routeName: (context) => PageAtivosCarteira(),
    };

    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.red,
        primaryColor: Colors.red,
        primaryColorDark: Colors.red,
        primaryColorLight: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: PageHome.routeName,
    );
  }
}
