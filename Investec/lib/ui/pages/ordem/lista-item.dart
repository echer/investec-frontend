import 'package:Investec/data/domain/ordem.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:Investec/ui/utils/DialogUtils.dart';
import 'package:flutter/material.dart';

import 'view-model.dart';

class ListaOrdemItem extends StatelessWidget {
  OrdemViewModel viewModel = getIt<OrdemViewModel>();

  final Ordem model;

  final VoidCallback onCountSelected;

  ListaOrdemItem(this.model, this.onCountSelected);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${model.tipoOrdem == 0 ? "COMPRA" : ""}${model.tipoOrdem == 1 ? "VENDA" : ""}',
        style: TextStyle(fontWeight: FontWeight.w400),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Quantidade: ${model.qtdOrdem} x (R\$ ${model.vlrOrdem} - R\$ ${model.taxaOrdem}) \nTotal: R\$ ${model.totalOrdem}',
        style: TextStyle(fontWeight: FontWeight.normal),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.green,
          size: 30,
        ),
        onPressed: () async {
          var dialog = DialogUtils(new GlobalKey<State>());
          dialog.showLoadingDialog(context, message: "Realizando operação...");
          await viewModel
              .delete(model.ativosCarteira.carteira.id, model.ativosCarteira.id,
                  model)
              .then((value) {
            dialog.hideDialog();
            onCountSelected();
          }, onError: (e) {
            print(e);
            dialog.hideDialog();
          }).catchError((error) {
            print(error);
            dialog.hideDialog();
          });
        },
      ),
      onTap: () {},
    );
  }
}
