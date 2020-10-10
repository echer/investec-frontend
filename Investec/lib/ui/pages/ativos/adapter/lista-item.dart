import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/ui/pages/ativos/page-cadastro.dart';
import 'package:flutter/material.dart';

class ListaAtivoItem extends StatelessWidget {
  final Ativo model;

  final VoidCallback onCountSelected;

  ListaAtivoItem(this.model, this.onCountSelected);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Ativo: ${model.ticker}',
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Quantidade: ${model.qtdAtivo} x Valor: ${model.pmAtivo} = Total: ${model.vlrInvestido}',
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
              .pushNamed(PageCadastroAtivo.routeName, arguments: model);
          if (information != null && information == "refresh") {
            onCountSelected();
          }
        },
      ),
      onTap: () {},
    );
  }
}
