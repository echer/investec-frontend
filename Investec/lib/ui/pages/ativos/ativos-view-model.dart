import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/repository/ativos-repository.dart';
import 'package:flutter/material.dart';

class AtivosViewModel extends ChangeNotifier {
  AtivosRepository repository = new AtivosRepository();

  List<Ativo> ativos = List<Ativo>();

  Future<void> list(String carteira) async {
    this.ativos = await repository.list(carteira);
    notifyListeners();
  }
}
