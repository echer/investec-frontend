import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/ui/pages/page-cadastro-carteira.dart';
import 'package:Investec/ui/pages/page-carteira-ativos.dart';
import 'package:flutter/material.dart';

class ListaCarteiraItem extends StatelessWidget {
  final Carteira model;

  ListaCarteiraItem(this.model);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Nome: ${model.nomeCarteira}',
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Data: ${model.dtCriacao}',
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
        onPressed: () => {
          Navigator.of(context)
              .pushNamed(PageCadastroCarteira.routeName, arguments: model)
        },
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(PageAtivosCarteira.routeName, arguments: model);
      },
      onLongPress: () => {
        //TODO EXCLUIR
      },
    );
  }
}
