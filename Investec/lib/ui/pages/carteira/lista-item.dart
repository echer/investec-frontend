import 'package:Investec/data/domain/carteiraprecovm.dart';
import 'package:Investec/ui/pages/ativos/page.dart';
import 'package:Investec/ui/utils/CurrencyPtBrInputFormatter.dart';
import 'package:Investec/ui/utils/DateUtils.dart';
import 'package:flutter/material.dart';

import 'page-cadastro.dart';

class ListaCarteiraItem extends StatelessWidget {
  final CarteiraPrecoVM model;
  final VoidCallback onCountSelected;

  ListaCarteiraItem(this.model, this.onCountSelected);

  @override
  Widget build(BuildContext context) {
    model.mostraCarteira = false;
    return ListTile(
      title: Text(
        '${model.carteira.nomeCarteira}',
        style: TextStyle(fontWeight: FontWeight.w400),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Saldo: ${CurrencyPtBrInputFormatter.doubleToStr(model.saldoAtual)} \nVariação: ${model.variacao}% \nMeta: ${CurrencyPtBrInputFormatter.doubleToStr(model.carteira.metaCarteira)} \nData: ${DateUtils.strIso8601ToStr(model.carteira.createdOn)}',
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
