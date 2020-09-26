import 'package:Investec/data/domain/carteira-ativo.dart';
import 'package:flutter/material.dart';

class PageCadastroAtivo extends StatelessWidget {
  static const routeName = '/cadastro/ativo';

  PageCadastroAtivo();

  @override
  Widget build(BuildContext context) {
    final AtivosCarteira ativo = ModalRoute.of(context).settings.arguments;
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
        title: Text(ativo == null || ativo.id.isEmpty
            ? 'Investec - Novo Ativo'
            : 'Investec - Editar: ${ativo.id}'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Cadastro de ativo aqui'),
        ),
      ),
    );
  }
}
