import 'package:Investec/data/domain/carteira-ativo.dart';
import 'package:Investec/data/repository/ativos-repository.dart';
import 'package:flutter/material.dart';

class AtivosViewModel extends ChangeNotifier {
  AtivosRepository repository = new AtivosRepository();

  List<AtivosCarteira> ativos = List<AtivosCarteira>();

  Future<void> list(String carteira) async {
    this.ativos = await repository.list(carteira);
    notifyListeners();
  }
}
