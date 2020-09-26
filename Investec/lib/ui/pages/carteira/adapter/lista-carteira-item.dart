import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/ui/pages/ativos/page-carteira-ativos.dart';
import 'package:Investec/ui/pages/carteira/page-cadastro-carteira.dart';
import 'package:flutter/material.dart';

class ListaCarteiraItem extends StatelessWidget {
  final Carteira model;

  ListaCarteiraItem(this.model);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Carteira: ${model.nomeCarteira}',
        style: TextStyle(fontWeight: FontWeight.bold),
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
        onPressed: () => {
          Navigator.of(context)
              .pushNamed(PageCadastroCarteira.routeName, arguments: model)
        },
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(PageAtivosCarteira.routeName, arguments: model);
      },
    );
  }
}
