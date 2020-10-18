import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/domain/ativoprecovm.dart';
import 'package:Investec/data/repository/ativos-repository.dart';
import 'package:flutter/material.dart';

class AtivosViewModel extends ChangeNotifier {
  final AtivosRepository repository;

  AtivosViewModel(this.repository);

  List<AtivoPrecoVM> ativos = List<AtivoPrecoVM>();

  Future<void> list(String carteira) async {
    this.ativos = await repository.list(carteira);
    notifyListeners();
  }

  Future<void> createOrUpdate(String carteira, Ativo obj) {
    if (obj.id.isEmpty) {
      obj.id = null;
      return repository.create(carteira, obj);
    }
    return repository.update(carteira, obj);
  }

  Future<void> delete(String carteira, Ativo obj) {
    return repository.delete(carteira, obj);
  }

  void notify() {
    notifyListeners();
  }
}
