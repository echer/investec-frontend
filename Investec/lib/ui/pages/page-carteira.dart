import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/ui/pages/page-cadastro-carteira.dart';
import 'package:Investec/ui/widgets/lista-carteira-item.dart';
import 'package:flutter/material.dart';

class PageCarteira extends StatelessWidget {
  static const routeName = '/carteira';

  PageCarteira();

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
        child: ListView(
          children: [
            ListaCarteiraItem(
              Carteira("guid", "Carteira 1", "20/09/2020", 0, 0, 0),
            ),
            Divider(
              color: Colors.grey,
            )
          ],
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
