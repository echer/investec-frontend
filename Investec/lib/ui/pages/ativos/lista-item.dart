import 'package:Investec/data/domain/ativoprecovm.dart';
import 'package:Investec/ui/pages/ordem/page.dart';
import 'package:Investec/ui/utils/CurrencyPtBrInputFormatter.dart';
import 'package:Investec/ui/utils/DateUtils.dart';
import 'package:flutter/material.dart';

import 'page-cadastro.dart';

class ListaAtivoItem extends StatelessWidget {
  final AtivoPrecoVM model;
  final bool mostraCarteira;

  final VoidCallback onCountSelected;

  ListaAtivoItem(this.model, this.mostraCarteira, this.onCountSelected);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        mostraCarteira
            ? '${model.ativo.carteira.nomeCarteira} \n${model.ativo.ticker}'
            : '${model.ativo.ticker}',
        style: TextStyle(fontWeight: FontWeight.w400),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Quantidade: ${model.ativo.qtdAtivo} x Valor: ${CurrencyPtBrInputFormatter.doubleToStr(model.ativo.pmAtivo)} = Total: ${CurrencyPtBrInputFormatter.doubleToStr(model.ativo.vlrInvestido)} \nData: ${DateUtils.strIso8601ToStr(model.ativo.createdOn)}',
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
