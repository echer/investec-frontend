import 'package:Investec/data/domain/carteira-ativo.dart';
import 'package:flutter/material.dart';

class PageCadastroAtivo extends StatefulWidget {
  static const routeName = '/cadastro/ativo';

  final AtivosCarteira ativo;

  PageCadastroAtivo(this.ativo);

  @override
  _PageCadastroAtivo createState() => _PageCadastroAtivo();
}

class _PageCadastroAtivo extends State<PageCadastroAtivo> {
  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.ativo == null || widget.ativo.id.isEmpty
            ? 'Investec - Novo Ativo'
            : 'Investec - Editar: ${widget.ativo.id}'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Cadastro de ativo aqui'),
        ),
      ),
    );
  }
}
