import 'package:Investec/data/domain/ativoprecovm.dart';
import 'package:Investec/ui/pages/ordem/page.dart';
import 'package:flutter/material.dart';

import 'page-cadastro.dart';

class ListaAtivoItem extends StatelessWidget {
  final AtivoPrecoVM model;

  final VoidCallback onCountSelected;

  ListaAtivoItem(this.model, this.onCountSelected);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${model.ativo.ticker} (Carteira: ${model.ativo.carteira.nomeCarteira})',
        style: TextStyle(fontWeight: FontWeight.w400),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Quantidade: ${model.ativo.qtdAtivo} x Valor: R\$ ${model.ativo.pmAtivo} = Total: R\$ ${model.ativo.vlrInvestido}',
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
              .pushNamed(PageCadastroAtivo.routeName, arguments: model.ativo);
          if (information != null && information == "refresh") {
            onCountSelected();
          }
        },
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(PageOrdensAtivo.routeName, arguments: model);
      },
    );
  }
}
