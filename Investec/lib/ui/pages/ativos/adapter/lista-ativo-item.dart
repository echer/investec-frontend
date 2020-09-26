import 'package:Investec/data/domain/carteira-ativo.dart';
import 'package:Investec/ui/pages/ativos/page-cadastro-ativo.dart';
import 'package:flutter/material.dart';

class ListaAtivoItem extends StatelessWidget {
  final AtivosCarteira model;

  ListaAtivoItem(this.model);

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
        onPressed: () => {
          Navigator.of(context)
              .pushNamed(PageCadastroAtivo.routeName, arguments: model)
        },
      ),
      onTap: () {},
    );
  }
}
