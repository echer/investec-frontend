import 'package:Investec/LoginApp.dart';
import 'package:Investec/ui/pages/carteira/page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageHome extends StatelessWidget {
  static const routeName = '/';

  PageHome();

  @override
  Widget build(BuildContext context) {
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
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
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
