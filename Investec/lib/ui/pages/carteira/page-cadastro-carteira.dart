import 'package:Investec/data/domain/carteira.dart';
import 'package:flutter/material.dart';

class PageCadastroCarteira extends StatefulWidget {
  static const routeName = '/cadastro/carteira';

  final Carteira carteira;

  PageCadastroCarteira(this.carteira);

  @override
  _PageCadastroCarteira createState() => _PageCadastroCarteira();
}

class _PageCadastroCarteira extends State<PageCadastroCarteira> {
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
        title: Text(widget.carteira == null || widget.carteira.id.isEmpty
            ? 'Investec - Nova Carteira'
            : 'Investec - Editar: ${widget.carteira.id}'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Cadastro/Editar de carteira aqui'),
        ),
      ),
    );
  }
}
