import 'package:Investec/data/domain/ordem.dart';
import 'package:flutter/material.dart';

import 'page-cadastro.dart';

class ListaOrdemItem extends StatelessWidget {
  final Ordem model;

  final VoidCallback onCountSelected;

  ListaOrdemItem(this.model, this.onCountSelected);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Ordem: ${model.id}',
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '',
        style: TextStyle(fontWeight: FontWeight.normal),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.edit,
          color: Colors.green,
          size: 30,
        ),
        onPressed: () async {
          final information = await Navigator.of(context)
              .pushNamed(PageCadastroOrdem.routeName, arguments: model);
          if (information != null && information == "refresh") {
            onCountSelected();
          }
        },
      ),
      onTap: () {},
    );
  }
}
