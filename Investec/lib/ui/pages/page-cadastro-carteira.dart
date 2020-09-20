import 'package:Investec/data/domain/carteira.dart';
import 'package:flutter/material.dart';

class PageCadastroCarteira extends StatelessWidget {
  static const routeName = '/cadastro/carteira';

  PageCadastroCarteira();

  @override
  Widget build(BuildContext context) {
    final Carteira carteira = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => {},
          ),
        ],
        title: Text(carteira == null || carteira.id.isEmpty
            ? 'Investec - Nova Carteira'
            : 'Investec - Editar: ${carteira.id}'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Cadastro/Editar de carteira aqui'),
        ),
      ),
    );
  }
}
