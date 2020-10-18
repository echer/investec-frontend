import 'package:Investec/data/domain/carteiraprecovm.dart';
import 'package:Investec/ui/pages/ativos/page.dart';
import 'package:flutter/material.dart';

import 'page-cadastro.dart';

class ListaCarteiraItem extends StatelessWidget {
  final CarteiraPrecoVM model;
  final VoidCallback onCountSelected;

  ListaCarteiraItem(this.model, this.onCountSelected);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Carteira: ${model.carteira.nomeCarteira}',
        style: TextStyle(fontWeight: FontWeight.w400),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Saldo: R\$ ${model.saldoAtual} \nVariação: ${model.variacao}% \nMeta: R\$ ${model.carteira.metaCarteira} \nData: ${model.carteira.createdOn}',
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.edit,
          color: Colors.green,
          size: 30,
        ),
        onPressed: () async {
          final information = await Navigator.of(context).pushNamed(
              PageCadastroCarteira.routeName,
              arguments: model.carteira);
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
