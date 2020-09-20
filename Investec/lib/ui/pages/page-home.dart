import 'package:Investec/ui/pages/page-carteira.dart';
import 'package:flutter/material.dart';

class PageHome extends StatelessWidget {
  static const routeName = '/';

  PageHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Investec - Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.money_off),
              title: Text('Minhas Carteiras'),
              onTap: () =>
                  {Navigator.of(context).pushNamed(PageCarteira.routeName)},
            )
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
