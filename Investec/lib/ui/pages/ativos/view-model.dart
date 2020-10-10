import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/repository/ativos-repository.dart';
import 'package:flutter/material.dart';

class AtivosViewModel extends ChangeNotifier {
  final AtivosRepository repository;

  AtivosViewModel(this.repository);

  List<Ativo> ativos = List<Ativo>();

  Future<void> list(String carteira) async {
    this.ativos = await repository.list(carteira);
    notifyListeners();
  }

  Future<void> createOrUpdate(Ativo obj) {
    if (obj.id.isEmpty) {
      obj.id = null;
      return repository.create(obj.carteiraId, obj);
    }
    return repository.update(obj.carteiraId, obj);
  }

  Future<void> delete(Ativo obj) {
    return repository.delete(obj.carteiraId, obj);
  }
}
