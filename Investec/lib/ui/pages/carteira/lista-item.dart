import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/ui/pages/ativos/page.dart';
import 'package:flutter/material.dart';

import 'page-cadastro.dart';

class ListaCarteiraItem extends StatelessWidget {
  final Carteira model;
  final VoidCallback onCountSelected;

  ListaCarteiraItem(this.model, this.onCountSelected);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Carteira: ${model.nomeCarteira}',
        style: TextStyle(fontWeight: FontWeight.w400),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Saldo: R\$ ${model.saldoCarteira} \nVariação: ${model.varCarteira}% \nMeta: R\$ ${model.metaCarteira} \nData: ${model.dtCriacao}',
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.edit,
          color: Colors.green,
          size: 30,
        ),
        onPressed: () async {
          final information = await Navigator.of(context)
              .pushNamed(PageCadastroCarteira.routeName, arguments: model);
          if (information != null && information == "refresh") {
            onCountSelected();
          }
        },
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(PageAtivosCarteira.routeName, arguments: model);
      },
    );
  }
}
