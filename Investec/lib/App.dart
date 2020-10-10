import 'package:Investec/ui/pages/ativos/page-cadastro.dart';
import 'package:Investec/ui/pages/carteira/page-cadastro.dart';
import 'package:Investec/ui/pages/carteira/page.dart';
import 'package:Investec/ui/pages/home/page.dart';
import 'package:Investec/ui/pages/ordem/page-cadastro.dart';
import 'package:Investec/ui/pages/ordem/page.dart';
import 'package:flutter/material.dart';

import 'ui/pages/ativos/page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.red,
        primaryColor: Colors.red,
        primaryColorDark: Colors.red,
        primaryColorLight: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        var routes = {
          PageHome.routeName: (context) => PageHome(),
          PageCarteira.routeName: (context) => PageCarteira(),
          PageAtivosCarteira.routeName: (context) =>
              PageAtivosCarteira(settings.arguments),
          PageOrdensAtivo.routeName: (context) =>
              PageOrdensAtivo(settings.arguments),
          PageCadastroCarteira.routeName: (context) =>
              PageCadastroCarteira(settings.arguments),
          PageCadastroAtivo.routeName: (context) =>
              PageCadastroAtivo(settings.arguments),
          PageCadastroOrdem.routeName: (context) =>
              PageCadastroOrdem(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      initialRoute: PageHome.routeName,
    );
  }
}
