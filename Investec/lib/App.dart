import 'package:Investec/ui/pages/ativos/page-cadastro-ativo.dart';
import 'package:Investec/ui/pages/carteira/page-cadastro-carteira.dart';
import 'package:Investec/ui/pages/carteira/page-carteira.dart';
import 'package:Investec/ui/pages/home/page-home.dart';
import 'package:flutter/material.dart';

import 'ui/pages/ativos/page-ativos.dart';

class App extends StatelessWidget {
  static const String authorization =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImRhYTdlZWFhLTQ5ODAtNDBmMS05NTUzLWFlNzllYzRlZmNhOCIsIm5iZiI6MTYwMTE2MTAzNSwiZXhwIjoxNjAxMTc5MDM1LCJpYXQiOjE2MDExNjEwMzV9.P9qkR0zpnm9CFnnC7RJUiBXEic6beZcm2TAaeHHw7GE";
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
          PageCadastroCarteira.routeName: (context) =>
              PageCadastroCarteira(settings.arguments),
          PageCadastroAtivo.routeName: (context) =>
              PageCadastroAtivo(settings.arguments),
          PageAtivosCarteira.routeName: (context) =>
              PageAtivosCarteira(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      initialRoute: PageHome.routeName,
    );
  }
}
