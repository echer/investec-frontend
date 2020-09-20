import 'package:Investec/data/domain/carteira-ativo.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/ui/pages/page-cadastro-ativo.dart';
import 'package:Investec/ui/widgets/lista-ativo-item.dart';
import 'package:flutter/material.dart';

class PageAtivosCarteira extends StatelessWidget {
  static const routeName = '/carteira/ativos';

  PageAtivosCarteira();

  @override
  Widget build(BuildContext context) {
    final Carteira carteira = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: Text('Investec - Ativos da carteira: ${carteira.nomeCarteira}'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListaAtivoItem(
              AtivosCarteira("guid", "AZUL4", 0, 0, 0, 0, 0),
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(PageCadastroAtivo.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
